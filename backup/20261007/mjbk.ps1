function MJ {
    <#
    .SYNOPSIS
        Interactive, nested explorer for mjdocs.json with search, filter, and export/report features.

    .DESCRIPTION
        Menu-driven explorer for the stewardship JSON at D:\mj.dev\docs\mjdocs.json.
        - Navigate Projects, Timeline, Contacts, Accounts, SystemRoles.
        - Drill into project details (TagLine, ShortDescription, Mission, Vision, Repository).
        - Drill into Timeline phases and tasks.
        - Search across Projects and Timeline tasks by keyword.
        - Export search results to JSON or text.
        - Export Timeline progress report (summary + progress bar) to a timestamped file.
        - All exports default to D:\mj.dev\docs\reports\ (created if missing).

    .PARAMETER Path
        Path to the JSON file. Default: D:\mj.dev\docs\mjdocs.json

    .NOTES
        Author: MJ Ahmad
        Purpose: Interactive stewardship review, audit-ready exports, and step-by-step inspection.
    #>

    param(
        [string]$Path = "E:\mj\mjc01\mjdev\mj.json"
    )

    # Ensure JSON exists
    if (-not (Test-Path $Path)) {
        Write-Error "JSON file not found at $Path"
        return
    }

    # Ensure reports folder
    $reportDir = "E:\mj\mjc01\outpot\reports"
    if (-not (Test-Path $reportDir)) { New-Item -Path $reportDir -ItemType Directory | Out-Null }

    # Load JSON
    try {
        $json = Get-Content $Path -Raw | ConvertFrom-Json
    } catch {
        Write-Error "Failed to parse JSON at $Path. $_"
        return
    }

    function Show-ProgressBarText {
        param($percent, $length = 30)
        $filled = [int]($length * $percent / 100)
        $bar = ("#" * $filled) + ("-" * ($length - $filled))
        return ("{0}% [{1}]" -f $percent, $bar)
    }

    while ($true) {
        Clear-Host
        Write-Host "=== MJDocs Explorer ===" -ForegroundColor Cyan
        Write-Host "1. View Projects"
        Write-Host "2. View Timeline"
        Write-Host "3. View Contacts"
        Write-Host "4. View Accounts"
        Write-Host "5. View SystemRoles"
        Write-Host "6. Search/Filter (with export)"
        Write-Host "7. Export Timeline Progress Report"
        Write-Host "8. Exit"
        $choice = Read-Host "Select an option (1-8)"

        switch ($choice) {
            "1" {
                $projects = $json.MJAhmad.Projects
                while ($true) {
                    Clear-Host
                    Write-Host "=== Projects ===" -ForegroundColor Cyan
                    $i = 1
                    foreach ($p in $projects) {
                        Write-Host "$i. [$($p.Id)] $($p.Name) ($($p.Key))" -ForegroundColor Yellow
                        $i++
                    }
                    Write-Host "$i. Back"
                    $projChoice = Read-Host "Enter project number"
                    if (-not $projChoice) { break }
                    if (-not ([int]::TryParse($projChoice, [ref]$null))) { Read-Host "Invalid input. Enter to continue"; continue }
                    if ([int]$projChoice -eq $i) { break }
                    if ([int]$projChoice -lt 1 -or [int]$projChoice -gt ($i-1)) { Read-Host "Out of range. Enter to continue"; continue }
                    $proj = $projects[[int]$projChoice - 1]

                    while ($true) {
                        Clear-Host
                        Write-Host "=== Project: $($proj.Name) ===" -ForegroundColor Cyan
                        Write-Host "1. TagLine"
                        Write-Host "2. ShortDescription"
                        Write-Host "3. Mission"
                        Write-Host "4. Vision"
                        Write-Host "5. Repository"
                        Write-Host "6. Export Project (JSON)"
                        Write-Host "7. Back"
                        $subChoice = Read-Host "Select detail"
                        switch ($subChoice) {
                            "1" { Write-Host $proj.TagLine; Read-Host "Enter to return" }
                            "2" { Write-Host $proj.ShortDescription; Read-Host "Enter to return" }
                            "3" { $proj.Mission | ForEach-Object { Write-Host " - $_" }; Read-Host "Enter to return" }
                            "4" { $proj.Vision | ForEach-Object { Write-Host " - $_" }; Read-Host "Enter to return" }
                            "5" { Write-Host "Path: $($proj.Repository.Path)"; Write-Host "Files: $($proj.Repository.ExampleFiles -join ', ')"; Read-Host "Enter to return" }
                            "6" {
                                $timestamp = (Get-Date).ToString("yyyyMMdd-HHmmss")
                                $outFile = Join-Path $reportDir ("project-{0}-{1}.json" -f $proj.Key, $timestamp)
                                $proj | ConvertTo-Json -Depth 10 | Out-File -FilePath $outFile -Encoding UTF8
                                Write-Host "Exported project to $outFile" -ForegroundColor Green
                                Read-Host "Enter to return"
                            }
                            "7" { break }
                            default { Write-Host "Invalid choice"; Read-Host "Enter to return" }
                        }
                    }
                }
            }

            "2" {
                Clear-Host
                $timeline = $json.MJAhmad.Timeline.Timeline

                   Write-Host "               === QuranerFariwala Recovery Workflow ===" -ForegroundColor Cyan
                   Write-Host "               WARNING:" -ForegroundColor Red
                   Write-Host "               The last and final attempt" -ForegroundColor Red
                   Write-Host "               No if, no uff. Either recovery or shutdown." -ForegroundColor Red
                   Write-Host "               ------------------------------------------" -ForegroundColor Cyan

                    foreach ($step in $timeline | Sort-Object {[int]$_.Step}) {
                       Write-Host "               Step $($step.Step): $($step.Description)" -ForegroundColor Yellow
                       Write-Host "               Status: $($step.Status)" -ForegroundColor Green
                       Write-Host ""
                    }

                    $completed = ($timeline | Where-Object { $_.Status -eq "Completed" }).Count
                    $progress  = ($timeline | Where-Object { $_.Status -eq "In Progress" }).Count
                    $pending   = ($timeline | Where-Object { $_.Status -eq "Pending" }).Count
                    $total     = $timeline.Count

                    # Calculate percentage of completed steps
                    $setupPercent = 0
                    if ($total -gt 0) {
                          $setupPercent = [math]::Round(($completed / $total) * 100, 2)
                    }

                       # Build progress bar (20 characters long)
                    $barLength = 20
                    $filled = [int]($barLength * $setupPercent / 100)
                    $empty = $barLength - $filled
                    $bar = ("#" * $filled) + ("-" * $empty)

                    Write-Host "               -------------------------------------------------------------------------" -ForegroundColor Cyan
                    Write-Host ""
                    Write-Host "               ✅ Completed: $completed" -ForegroundColor Green
                    Write-Host "               🔄 In Progress: $progress" -ForegroundColor Yellow
                    Write-Host "               ⏳ Pending: $pending" -ForegroundColor DarkCyan
                    Write-Host "               ------------------" -ForegroundColor Cyan
                    Write-Host ("               Setup - {0}% [{1}]" -f $setupPercent, $bar) -ForegroundColor DarkYellow
                    Write-Host ""
                    if (-Not (Test-Path $Path)) {
                        Write-Host "mj.json not found at $Path" -ForegroundColor Red
                        return
                    }
                    Read-Host "               Enter to return"
            }

            "3" {
                $contacts = $json.MJAhmad.Contacts
                while ($true) {
                    Clear-Host
                    Write-Host "=== Contacts ===" -ForegroundColor Cyan
                    Write-Host "1. Donors"
                    Write-Host "2. Supporters"
                    Write-Host "3. Investors"
                    Write-Host "4. QuranOrders"
                    Write-Host "5. Creditors"
                    Write-Host "6. Family"
                    Write-Host "7. Friends"
                    Write-Host "8. Business"
                    Write-Host "9. Classmates"
                    Write-Host "10. Nighttime"
                    Write-Host "11. LegalIssues"
                    Write-Host "12. Export Contacts (JSON)"
                    Write-Host "13. Back"
                    $contactChoice = Read-Host "Select an option"

                    switch ($contactChoice) {
                        "1" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== Donors ===" -ForegroundColor Cyan

                                $i = 1
                                foreach ($d in $contacts.Donors) {
                                    $donorProfile = $d
                                    Write-Host "$i. Donor Id        : $($donorProfile.Id)" -ForegroundColor Yellow
                                    Write-Host "   Name            : $($donorProfile.Name)"
                                    if ($donorProfile.Contact.Phones) { Write-Host "   Phone           : $($donorProfile.Contact.Phones -join ', ')" }
                                    Write-Host ""
                                    $i++
                                }

                                $id = Read-Host "Enter Donor Id for details (or blank to go back)"
                                if (-not $id) { break }

                                $selected = $contacts.Donors | Where-Object { $_.Id -eq $id }
                                if ($selected) {
                                    Clear-Host
                                    $donorProfile = $selected
                                    Write-Host "=== Donor Details ===" -ForegroundColor Cyan
                                    Write-Host "Id              : $($donorProfile.Id)"
                                    Write-Host "Name            : $($donorProfile.Name)"
                                    Write-Host "Location        : $($donorProfile.Location)"
                                    Write-Host "Type            : $($donorProfile.Type)"

                                    if ($donorProfile.Contact.Phones) { Write-Host "Phones          : $($donorProfile.Contact.Phones -join ', ')" }
                                    Write-Host "Email           : $($donorProfile.Contact.Email)"
                                    Write-Host "Mediator        : $($donorProfile.Mediator)"

                                    if ($donorProfile.Notes) { Write-Host "Notes           : $($donorProfile.Notes -join ' | ')" }

                                    Write-Host "`nTransactions:"
                                    foreach ($t in $donorProfile.Transactions) {
                                        Write-Host " - TransactionId: $($t.TransactionId), Date: $($t.Date), Type: $($t.Type), Mode: $($t.Mode), Amount: $($t.Amount)"
                                        if ($t.Notes) { Write-Host "   Notes        : $($t.Notes)" }
                                    }

                                    Write-Host "`nSource          : $($donorProfile.Source)"
                                    Write-Host "Acknowledgement  : ReceiptIssued=$($donorProfile.Acknowledgement.ReceiptIssued), ReceiptNumber=$($donorProfile.Acknowledgement.ReceiptNumber), PublicListing=$($donorProfile.Acknowledgement.PublicListing)"
                                    Write-Host "CreatedAt        : $($donorProfile.CreatedAt)"
                                    Write-Host "UpdatedAt        : $($donorProfile.UpdatedAt)"
                                    Read-Host "Enter to return"
                                } else {
                                    Write-Host "Donor Id not found." -ForegroundColor Red
                                    Read-Host "Enter to continue"
                                }
                            }
                        }

                        "2" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== Supporters ===" -ForegroundColor Cyan
                                $i = 1
                                foreach ($s in $contacts.Supporters) {
                                    $supporterProfile = $s
                                    Write-Host "$i. Supporter Id   : $($supporterProfile.Id)" -ForegroundColor Yellow
                                    Write-Host "   Name            : $($supporterProfile.Name)"
                                    if ($supporterProfile.Contact.Phones) { Write-Host "   Phone           : $($supporterProfile.Contact.Phones -join ', ')" }
                                    Write-Host ""
                                    $i++
                                }
                                $id = Read-Host "Enter Supporter Id for details (or blank to go back)"
                                if (-not $id) { break }

                                $selected = $contacts.Supporters | Where-Object { $_.Id -eq $id }
                                if ($selected) {
                                    Clear-Host
                                    $supporterProfile = $selected
                                    Write-Host "=== Supporter Details ===" -ForegroundColor Cyan
                                    Write-Host "Id              : $($supporterProfile.Id)"
                                    Write-Host "Name            : $($supporterProfile.Name)"
                                    Write-Host "Location        : $($supporterProfile.Location)"
                                    if ($supporterProfile.Contact.Phones) { Write-Host "Phones          : $($supporterProfile.Contact.Phones -join ', ')" }
                                    Write-Host "Email           : $($supporterProfile.Contact.Email)"
                                    Write-Host "Type            : $($supporterProfile.Type)"
                                    Write-Host "Mediator        : $($supporterProfile.Mediator)"
                                    if ($supporterProfile.Notes) { Write-Host "Notes           : $($supporterProfile.Notes -join ' | ')" }

                                    Write-Host "`nTransactions:"
                                    foreach ($t in $supporterProfile.Transactions) {
                                        Write-Host " - TransactionId: $($t.TransactionId), Date: $($t.Date), Type: $($t.Type), Mode: $($t.Mode), Amount: $($t.Amount)"
                                        if ($t.PaymentReference) { Write-Host "   PaymentRef   : $($t.PaymentReference)" }
                                        if ($t.Notes) { Write-Host "   Notes        : $($t.Notes)" }
                                    }

                                    if ($supporterProfile.Summary) {
                                        Write-Host "`nSummary:"
                                        Write-Host "   TotalProvided : $($supporterProfile.Summary.TotalProvided)"
                                        Write-Host "   Outstanding   : $($supporterProfile.Summary.OutstandingReceivable)"
                                        Write-Host "   Status        : $($supporterProfile.Summary.Status)"
                                    }
                                    if ($supporterProfile.Receivable) {
                                        Write-Host "`nReceivable:"
                                        Write-Host "   Amount        : $($supporterProfile.Receivable.Amount)"
                                        Write-Host "   DueDate       : $($supporterProfile.Receivable.DueDate)"
                                        Write-Host "   Status        : $($supporterProfile.Receivable.Status)"
                                        if ($supporterProfile.Receivable.FollowUpPlan) { Write-Host "   FollowUpPlan  : $($supporterProfile.Receivable.FollowUpPlan -join ' | ')" }
                                    }

                                    Write-Host "`nAcknowledgement  : ReceiptIssued=$($supporterProfile.Acknowledgement.ReceiptIssued), ReceiptNumber=$($supporterProfile.Acknowledgement.ReceiptNumber), PublicListingConsent=$($supporterProfile.Acknowledgement.PublicListingConsent)"
                                    Write-Host "Source           : $($supporterProfile.Source)"
                                    Write-Host "CreatedAt        : $($supporterProfile.CreatedAt)"
                                    Write-Host "UpdatedAt        : $($supporterProfile.UpdatedAt)"
                                    Read-Host "Enter to return"
                                } else {
                                    Write-Host "Supporter Id not found." -ForegroundColor Red
                                    Read-Host "Enter to continue"
                                }
                            }
                        }

                        "3" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== Investors ===" -ForegroundColor Cyan
                                $i = 1
                                foreach ($inv in $contacts.Investors) {
                                    $investorProfile = $inv
                                    Write-Host "$i. Investor Id    : $($investorProfile.Id)" -ForegroundColor Yellow
                                    Write-Host "   Name            : $($investorProfile.Name)"
                                    if ($investorProfile.Contact -and $investorProfile.Contact.Phones) {
                                        Write-Host "   Phone           : $($investorProfile.Contact.Phones -join ', ')"
                                    }
                                    Write-Host ""
                                    $i++
                                }

                                $id = Read-Host "Enter Investor Id for details (or blank to go back)"
                                if (-not $id) { break }

                                $selected = $contacts.Investors | Where-Object { $_.Id -eq $id }
                                if (-not $selected) {
                                    Write-Host "Investor Id not found." -ForegroundColor Red
                                    Read-Host "Enter to continue"
                                    continue
                                }

                                Clear-Host
                                $investorProfile = $selected
                                Write-Host "=== Investor Details ===" -ForegroundColor Cyan
                                Write-Host "Id                 : $($investorProfile.Id)"
                                Write-Host "Key                : $($investorProfile.Key)"
                                Write-Host "Name               : $($investorProfile.Name)"
                                Write-Host "Type               : $($investorProfile.Type)"
                                Write-Host "Principal-Amount   : $($investorProfile.'Principal-Amount')"
                                Write-Host "DividendRate       : $($investorProfile.DividendRate)"

                                Write-Host "`nIdentifiers:"
                                if ($investorProfile.Identifiers) {
                                    if ($investorProfile.Identifiers.NID) { Write-Host "   NID             : $($investorProfile.Identifiers.NID)" }
                                    if ($investorProfile.Identifiers.BirthRegNo) { Write-Host "   BirthRegNo      : $($investorProfile.Identifiers.BirthRegNo)" }
                                }

                                Write-Host "`nPersonal:"
                                if ($investorProfile.Personal) {
                                    if ($investorProfile.Personal.FullName) { Write-Host "   FullName        : $($investorProfile.Personal.FullName)" }
                                    if ($investorProfile.Personal.Nickname) { Write-Host "   Nickname        : $($investorProfile.Personal.Nickname)" }
                                    if ($investorProfile.Personal.DateOfBirth) { Write-Host "   DateOfBirth     : $($investorProfile.Personal.DateOfBirth)" }
                                    if ($investorProfile.Personal.Nationality) { Write-Host "   Nationality     : $($investorProfile.Personal.Nationality)" }
                                    if ($investorProfile.Personal.Location) { Write-Host "   Location        : $($investorProfile.Personal.Location)" }
                                    if ($investorProfile.Personal.Address) { Write-Host "   Address         : $($investorProfile.Personal.Address)" }
                                }

                                Write-Host "`nContact:"
                                if ($investorProfile.Contact) {
                                    if ($investorProfile.Contact.Email) { Write-Host "   Email           : $($investorProfile.Contact.Email)" }
                                    if ($investorProfile.Contact.Phones) { Write-Host "   Phones          : $($investorProfile.Contact.Phones -join ', ')" }
                                    if ($investorProfile.Contact.WhatsApp) { Write-Host "   WhatsApp        : $($investorProfile.Contact.WhatsApp)" }
                                }

                                if ($investorProfile.Notes) {
                                    Write-Host "`nNotes           : $($investorProfile.Notes -join ' | ')"
                                }

                                if ($investorProfile.Agreement) {
                                    Write-Host "`nAgreement Title  : $($investorProfile.Agreement.Title)"
                                    if ($investorProfile.Agreement.Clauses) {
                                        Write-Host "Agreement Clauses:"
                                        $investorProfile.Agreement.Clauses.PSObject.Properties |
                                            ForEach-Object { Write-Host "   $($_.Name) : $($_.Value)" }
                                    }
                                }

                                Write-Host "`nTransactions:"
                                if ($investorProfile.Transactions) {
                                    foreach ($t in $investorProfile.Transactions) {
                                        $line = " - TransactionId: $($t.TransactionId)"
                                        if ($t.Date) { $line += ", Date: $($t.Date)" }
                                        if ($t.Type) { $line += ", Type: $($t.Type)" }
                                        if ($t.Mode) { $line += ", Mode: $($t.Mode)" }
                                        if ($t.Amount) { $line += ", Amount: $($t.Amount)" }
                                        Write-Host $line
                                        if ($t.Notes) { Write-Host "   Notes        : $($t.Notes)" }
                                    }
                                }

                                Write-Host "`nSource           : $($investorProfile.Source)"
                                Write-Host "CreatedAt         : $($investorProfile.CreatedAt)"
                                Write-Host "UpdatedAt         : $($investorProfile.UpdatedAt)"
                                Read-Host "Enter to return"
                            }
                        }

                        "4" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== Quran Orders ===" -ForegroundColor Cyan
                                $i = 1
                                foreach ($q in $contacts.QuranOrders) {
                                    $orderProfile = $q.OrderProfile
                                    Write-Host "$i. Order Id        : $($orderProfile.Id)" -ForegroundColor Yellow
                                    Write-Host "   Customer        : $($orderProfile.CustomerName)"
                                    if ($orderProfile.Contact.Phones) { Write-Host "   Phone           : $($orderProfile.Contact.Phones -join ', ')" }
                                    Write-Host ""
                                    $i++
                                }
                                $orderId = Read-Host "Enter Order Id for details (or blank to go back)"
                                if (-not $orderId) { break }

                                $selected = $contacts.QuranOrders | Where-Object { $_.OrderProfile.Id -eq $orderId }
                                if ($selected) {
                                    Clear-Host
                                    $orderProfile = $selected.OrderProfile
                                    Write-Host "=== Quran Order Details ===" -ForegroundColor Cyan
                                    Write-Host "Order Id        : $($orderProfile.Id)"
                                    Write-Host "Customer        : $($orderProfile.CustomerName)"
                                    Write-Host "Phone           : $($orderProfile.Contact.Phone)"
                                    Write-Host "OrderDate       : $($orderProfile.OrderDate)"
                                    Write-Host "AmountPaid      : $($orderProfile.AmountPaid)"
                                    Write-Host "DeliveryStatus  : $($orderProfile.DeliveryStatus)"
                                    Write-Host "Mediator        : $($orderProfile.Mediator)"
                                    if ($orderProfile.Notes) { Write-Host "Notes           : $($orderProfile.Notes -join ', ')" }

                                    Write-Host "`nTransactions:"
                                    foreach ($t in $selected.Transactions) {
                                        Write-Host " - TransactionId: $($t.TransactionId), Date: $($t.Date), Type: $($t.Type), Mode: $($t.Mode), Amount: $($t.Amount), Notes: $($t.Notes)"
                                    }

                                    Write-Host "`nApologyNote    : $($selected.ApologyNote)"
                                    Write-Host "RefundPlan      : Option=$($selected.RefundPlan.Option), Amount=$($selected.RefundPlan.Amount), Timeline=$($selected.RefundPlan.Timeline), Status=$($selected.RefundPlan.Status)"
                                    Write-Host "ReInstruction   : Option=$($selected.ReInstructionPlan.Option), ExpectedDate=$($selected.ReInstructionPlan.ExpectedDate), Status=$($selected.ReInstructionPlan.Status)"
                                    Write-Host "Acknowledgement : ReceiptIssued=$($selected.Acknowledgement.ReceiptIssued), ReceiptNumber=$($selected.Acknowledgement.ReceiptNumber), PublicListingConsent=$($selected.Acknowledgement.PublicListingConsent)"
                                    Write-Host "CreatedAt       : $($selected.CreatedAt)"
                                    Write-Host "UpdatedAt       : $($selected.UpdatedAt)"
                                    Read-Host "Enter to return"
                                } else {
                                    Write-Host "Order Id not found." -ForegroundColor Red
                                    Read-Host "Enter to continue"
                                }
                            }
                        }

                        "5" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== Creditors ===" -ForegroundColor Cyan
                                $i = 1
                                foreach ($c in $contacts.Creditors) {
                                    $creditorProfile = $c.CreditorProfile
                                    Write-Host "$i. Creditor Id   : $($creditorProfile.Id)" -ForegroundColor Yellow
                                    Write-Host "   Name           : $($creditorProfile.Name)"
                                    Write-Host "   Source         : $($creditorProfile.Source)"
                                    if ($creditorProfile.Contact.Phone) { Write-Host "   Phone          : $($creditorProfile.Contact.Phone)" }
                                    Write-Host ""
                                    $i++
                                }
                                $credId = Read-Host "Enter Creditor Id for details (or blank to go back)"
                                if (-not $credId) { break }

                                $selected = $contacts.Creditors | Where-Object { $_.CreditorProfile.Id -eq $credId }
                                if ($selected) {
                                    Clear-Host
                                    $creditorProfile = $selected.CreditorProfile
                                    Write-Host "=== Creditor Details ===" -ForegroundColor Cyan
                                    Write-Host "Creditor Id     : $($creditorProfile.Id)"
                                    Write-Host "Name            : $($creditorProfile.Name)"
                                    Write-Host "Source          : $($creditorProfile.Source)"
                                    Write-Host "Phone           : $($creditorProfile.Contact.Phone)"
                                    Write-Host "OutstandingAmt  : $($creditorProfile.OutstandingAmount)"
                                    Write-Host "DueDate         : $($creditorProfile.DueDate)"
                                    Write-Host "Status          : $($creditorProfile.Status)"
                                    if ($creditorProfile.Notes) { Write-Host "Notes           : $($creditorProfile.Notes -join ', ')" }

                                    Write-Host "`nApologyNote    : $($selected.ApologyNote)"
                                    Write-Host "RefundPlan      : Option=$($selected.RefundPlan.Option), Amount=$($selected.RefundPlan.Amount), Timeline=$($selected.RefundPlan.Timeline), Status=$($selected.RefundPlan.Status)"
                                    if ($selected.RefundPlan.FollowUpActions) { Write-Host "FollowUpActions : $($selected.RefundPlan.FollowUpActions -join ', ')" }
                                    Write-Host "CreatedAt       : $($selected.CreatedAt)"
                                    Write-Host "UpdatedAt       : $($selected.UpdatedAt)"
                                    Read-Host "Enter to return"
                                } else {
                                    Write-Host "Creditor Id not found." -ForegroundColor Red
                                    Read-Host "Enter to continue"
                                }
                            }
                        }

                        "6" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== Family ===" -ForegroundColor Cyan
                                $i = 1
                                foreach ($f in $contacts.General) {
                                    $familyProfile = $f
                                    Write-Host "$i. Id              : $($familyProfile.Id)" -ForegroundColor Yellow
                                    Write-Host "   Name            : $($familyProfile.Name)"
                                    if ($familyProfile.Phone) { Write-Host "   Phone           : $($familyProfile.Phone)" }
                                    Write-Host ""
                                    $i++
                                }
                                $id = Read-Host "Enter Family Id for details (or blank to go back)"
                                if (-not $id) { break }

                                $selected = $contacts.Family | Where-Object { $_.Id -eq $id }
                                if ($selected) {
                                    Clear-Host
                                    $familyProfile = $selected
                                    Write-Host "=== Family Contact ===" -ForegroundColor Cyan
                                    Write-Host "Id       : $($familyProfile.Id)"
                                    Write-Host "Name     : $($familyProfile.Name)"
                                    Write-Host "Phone    : $($familyProfile.Phone)"
                                    Write-Host "WhatsApp : $($familyProfile.WhatsApp)"
                                    Write-Host "Email    : $($familyProfile.Email)"
                                    Write-Host "Note     : $($familyProfile.Note)"
                                    Write-Host "CreatedAt: $($familyProfile.CreatedAt)"
                                    Write-Host "UpdatedAt: $($familyProfile.UpdatedAt)"
                                    Read-Host "Enter to return"
                                } else {
                                    Write-Host "Family Id not found." -ForegroundColor Red
                                    Read-Host "Enter to continue"
                                }
                            }
                        }

                        "7" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== Friends ===" -ForegroundColor Cyan
                                $i = 1
                                foreach ($fr in $contacts.Friends) {
                                    $friendProfile = $fr
                                    Write-Host "$i. Id              : $($friendProfile.Id)" -ForegroundColor Yellow
                                    Write-Host "   Name            : $($friendProfile.Name)"
                                    if ($friendProfile.Phone) { Write-Host "   Phone           : $($friendProfile.Phone)" }
                                    Write-Host ""
                                    $i++
                                }
                                $id = Read-Host "Enter Friend Id for details (or blank to go back)"
                                if (-not $id) { break }

                                $selected = $contacts.Friends | Where-Object { $_.Id -eq $id }
                                if ($selected) {
                                    Clear-Host
                                    $friendProfile = $selected
                                    Write-Host "=== Friend Contact ===" -ForegroundColor Cyan
                                    Write-Host "Id       : $($friendProfile.Id)"
                                    Write-Host "Name     : $($friendProfile.Name)"
                                    Write-Host "Phone    : $($friendProfile.Phone)"
                                    Write-Host "WhatsApp : $($friendProfile.WhatsApp)"
                                    Write-Host "Email    : $($friendProfile.Email)"
                                    Write-Host "Note     : $($friendProfile.Note)"
                                    Write-Host "CreatedAt: $($friendProfile.CreatedAt)"
                                    Write-Host "UpdatedAt: $($friendProfile.UpdatedAt)"
                                    Read-Host "Enter to return"
                                } else {
                                    Write-Host "Friend Id not found." -ForegroundColor Red
                                    Read-Host "Enter to continue"
                                }
                            }
                        }

                        "8" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== Business ===" -ForegroundColor Cyan
                                $i = 1
                                foreach ($b in $contacts.Business) {
                                    $businessProfile = $b
                                    Write-Host "$i. Id              : $($businessProfile.Id)" -ForegroundColor Yellow
                                    Write-Host "   Name            : $($businessProfile.Name)"
                                    if ($businessProfile.Phone) { Write-Host "   Phone           : $($businessProfile.Phone)" }
                                    Write-Host ""
                                    $i++
                                }
                                $id = Read-Host "Enter Business Id for details (or blank to go back)"
                                if (-not $id) { break }

                                $selected = $contacts.Business | Where-Object { $_.Id -eq $id }
                                if ($selected) {
                                    Clear-Host
                                    $businessProfile = $selected
                                    Write-Host "=== Business Contact ===" -ForegroundColor Cyan
                                    Write-Host "Id       : $($businessProfile.Id)"
                                    Write-Host "Name     : $($businessProfile.Name)"
                                    Write-Host "Phone    : $($businessProfile.Phone)"
                                    Write-Host "WhatsApp : $($businessProfile.WhatsApp)"
                                    Write-Host "Email    : $($businessProfile.Email)"
                                    Write-Host "Note     : $($businessProfile.Note)"
                                    Write-Host "CreatedAt: $($businessProfile.CreatedAt)"
                                    Write-Host "UpdatedAt: $($businessProfile.UpdatedAt)"
                                    Read-Host "Enter to return"
                                } else {
                                    Write-Host "Business Id not found." -ForegroundColor Red
                                    Read-Host "Enter to continue"
                                }
                            }
                        }

                        "9" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== Classmates ===" -ForegroundColor Cyan
                                $i = 1
                                foreach ($c in $contacts.Classmates) {
                                    $classmateProfile = $c
                                    Write-Host "$i. Id              : $($classmateProfile.Id)" -ForegroundColor Yellow
                                    Write-Host "   Name            : $($classmateProfile.Name)"
                                    if ($classmateProfile.Phone) { Write-Host "   Phone           : $($classmateProfile.Phone)" }
                                    Write-Host ""
                                    $i++
                                }
                                $id = Read-Host "Enter Classmate Id for details (or blank to go back)"
                                if (-not $id) { break }

                                $selected = $contacts.Classmates | Where-Object { $_.Id -eq $id }
                                if ($selected) {
                                    Clear-Host
                                    $classmateProfile = $selected
                                    Write-Host "=== Classmate Contact ===" -ForegroundColor Cyan
                                    Write-Host "Id       : $($classmateProfile.Id)"
                                    Write-Host "Name     : $($classmateProfile.Name)"
                                    Write-Host "Phone    : $($classmateProfile.Phone)"
                                    Write-Host "WhatsApp : $($classmateProfile.WhatsApp)"
                                    Write-Host "Email    : $($classmateProfile.Email)"
                                    Write-Host "Note     : $($classmateProfile.Note)"
                                    Write-Host "CreatedAt: $($classmateProfile.CreatedAt)"
                                    Write-Host "UpdatedAt: $($classmateProfile.UpdatedAt)"
                                    Read-Host "Enter to return"
                                } else {
                                    Write-Host "Classmate Id not found." -ForegroundColor Red
                                    Read-Host "Enter to continue"
                                }
                            }
                        }

                        "10" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== Nighttime ===" -ForegroundColor Cyan
                                $i = 1
                                foreach ($n in $contacts.Personal.Nighttime) {
                                    $nightProfile = $n
                                    Write-Host "$i. Id              : $($nightProfile.Id)" -ForegroundColor Yellow
                                    Write-Host "   Name            : $($nightProfile.Name)"
                                    if ($nightProfile.Phone) { Write-Host "   Phone           : $($nightProfile.Phone)" }
                                    Write-Host ""
                                    $i++
                                }
                                $id = Read-Host "Enter Nighttime Id for details (or blank to go back)"
                                if (-not $id) { break }

                                $selected = $contacts.Personal.Nighttime | Where-Object { $_.Id -eq $id }
                                if ($selected) {
                                    Clear-Host
                                    $nightProfile = $selected
                                    Write-Host "=== Nighttime Contact ===" -ForegroundColor Cyan
                                    Write-Host "Id       : $($nightProfile.Id)"
                                    Write-Host "Name     : $($nightProfile.Name)"
                                    Write-Host "Phone    : $($nightProfile.Phone)"
                                    Write-Host "WhatsApp : $($nightProfile.WhatsApp)"
                                    Write-Host "Email    : $($nightProfile.Email)"
                                    Write-Host "Note     : $($nightProfile.Note)"
                                    Write-Host "CreatedAt: $($nightProfile.CreatedAt)"
                                    Write-Host "UpdatedAt: $($nightProfile.UpdatedAt)"
                                    Read-Host "Enter to return"
                                } else {
                                    Write-Host "Nighttime Id not found." -ForegroundColor Red
                                    Read-Host "Enter to continue"
                                }
                            }
                        }

                        "11" {
                            while ($true) {
                                Clear-Host
                                Write-Host "=== LegalIssues ===" -ForegroundColor Cyan
                                if ($contacts.LegalIssues) {
                                    $i = 1
                                    foreach ($li in $contacts.LegalIssues) {
                                        Write-Host "$i. Case Id : $($li.Id)" -ForegroundColor Yellow
                                        Write-Host "   Title   : $($li.Title)"
                                        Write-Host ""
                                        $i++
                                    }
                                    $id = Read-Host "Enter Case Id for details (or blank to go back)"
                                    if (-not $id) { break }

                                    $selected = $contacts.LegalIssues | Where-Object { $_.Id -eq $id }
                                    if ($selected) {
                                        Clear-Host
                                        Write-Host "=== Legal Case Details ===" -ForegroundColor Cyan
                                        Write-Host "Id       : $($selected.Id)"
                                        Write-Host "Title    : $($selected.Title)"
                                        Write-Host "Status   : $($selected.Status)"
                                        if ($selected.Notes) { Write-Host "Notes    : $($selected.Notes -join ' | ')" }
                                        Read-Host "Enter to return"
                                    } else {
                                        Write-Host "Case Id not found." -ForegroundColor Red
                                        Read-Host "Enter to continue"
                                    }
                                } else {
                                    Write-Host "No LegalIssues found." -ForegroundColor Yellow
                                    Read-Host "Enter to return"
                                    break
                                }
                            }
                        }

                        "12" {
                            # Export contacts as JSON
                            $exportPath = Read-Host "Enter export path (e.g., D:\export\contacts.json)"
                            if ($exportPath) {
                                $contacts | ConvertTo-Json -Depth 10 | Out-File -FilePath $exportPath -Encoding UTF8
                                Write-Host "Contacts exported to $exportPath" -ForegroundColor Green
                                Read-Host "Enter to continue"
                            }
                        }

                        "13" {
                            break
                        }

                        default {
                            Write-Host "Invalid option." -ForegroundColor Red
                            Start-Sleep -Seconds 1
                        }
                    } # end switch

                    break
                } # end while
            } 

            "4" {
                Clear-Host
                $json = Get-Content $Path | ConvertFrom-Json
                Write-Host "`n=== Quraner Fariwala Accounts ===" -ForegroundColor Cyan
                Write-Host ""
                foreach ($bank in $json.MJAhmad.Finance.Accounts.BankAccounts) {
                    Write-Host "Bank  : $($bank.Bank) | Branch: $($bank.Branch) | AccountName: $($bank.AccountName) | AccountNumber: $($bank.AccountNumber) | RoutingNumber: $($bank.RoutingNumber) | Status: $($bank.Status)" -ForegroundColor Yellow
                }
                foreach ($mobile in $json.MJAhmad.Finance.Accounts.MobileBanking) {
                    Write-Host "Mobile: $($mobile.Provider) | Number: $($mobile.Number) | Status: $($mobile.Status)" -ForegroundColor Cyan
                }
                Write-Host "GitHub Sponsors: $($json.MJAhmad.Finance.Accounts.Sponsors.Status)" -ForegroundColor Green
                Write-Host "ETH Wallet     : $($json.MJAhmad.Finance.Accounts.Crypto.Status)" -ForegroundColor Green
                if (-Not (Test-Path $Path)) {
                    Write-Host "Master data file not found." -ForegroundColor Red
                    return
                }
                Read-Host "Enter to return"
            }

            "5" {
                Clear-Host
                Write-Host "=== SystemRoles ===" -ForegroundColor Cyan
                if ($json.MJAhmad.SystemRoles) {
                    $json.MJAhmad.SystemRoles | Format-Table System, RoleTitle, StewardshipFunction -AutoSize
                } else {
                    Write-Host "No SystemRoles found." -ForegroundColor DarkYellow
                }
                Read-Host "Enter to return"
            }

            "6" {
                Clear-Host
                $keyword = Read-Host "Enter keyword to search (regex supported)"
                if (-not $keyword) { Read-Host "No keyword entered. Enter to return"; continue }
                Write-Host "=== Search Results for '$keyword' ===" -ForegroundColor Cyan

                $results = [System.Collections.ArrayList]::new()

                # Search Projects (Name, TagLine, ShortDescription, Mission, Vision)
                foreach ($proj in $json.MJAhmad.Projects) {
                    $hay = ($proj.Name, $proj.TagLine, $proj.ShortDescription, ($proj.Mission -join " "), ($proj.Vision -join " ")) -join "`n"
                    if ($hay -match $keyword) {
                        $entry = [PSCustomObject]@{
                            Type = "Project"
                            Key  = $proj.Key
                            Id   = $proj.Id
                            Name = $proj.Name
                            MatchExcerpt = ($hay -split "`n" | Where-Object { $_ -match $keyword } | Select-Object -First 3) -join " | "
                        }
                        $results.Add($entry) | Out-Null
                        Write-Host "Project: $($proj.Name) [$($proj.Key)]" -ForegroundColor Yellow
                        Write-Host "  Excerpt: $($entry.MatchExcerpt)`n" -ForegroundColor DarkGray
                    }
                }

                # Search Timeline tasks
                $timeline = $json.MJAhmad.Timeline[0].Phases
                foreach ($phase in $timeline) {
                    foreach ($task in $phase.Tasks) {
                        $hay = ($task.TaskID, $task.Section, $task.Description) -join " "
                        if ($hay -match $keyword) {
                            $entry = [PSCustomObject]@{
                                Type = "TimelineTask"
                                Phase = $phase.Title
                                TaskID = $task.TaskID
                                Description = $task.Description
                                Status = $task.Status
                            }
                            $results.Add($entry) | Out-Null
                            Write-Host "Timeline Task $($task.TaskID): $($task.Description) (Status: $($task.Status))" -ForegroundColor Green
                        }
                    }
                }

                if ($results.Count -eq 0) {
                    Write-Host "`nNo matches found." -ForegroundColor DarkYellow
                    Read-Host "Enter to return"
                    continue
                }

                Write-Host "`nOptions:"
                Write-Host "1. Export results as JSON"
                Write-Host "2. Export results as text summary"
                Write-Host "3. Return"
                $exportChoice = Read-Host "Select option"
                switch ($exportChoice) {
                    "1" {
                        $timestamp = (Get-Date).ToString("yyyyMMdd-HHmmss")
                        $outFile = Join-Path $reportDir ("search-results-{0}.json" -f $timestamp)
                        $results | ConvertTo-Json -Depth 6 | Out-File -FilePath $outFile -Encoding UTF8
                        Write-Host "Exported JSON to $outFile" -ForegroundColor Green
                        Read-Host "Enter to return"
                    }
                    "2" {
                        $timestamp = (Get-Date).ToString("yyyyMMdd-HHmmss")
                        $outFile = Join-Path $reportDir ("search-results-{0}.txt" -f $timestamp)
                        $sb = New-Object System.Text.StringBuilder
                        $sb.AppendLine("Search results for: $keyword") | Out-Null
                        $sb.AppendLine("Generated: $(Get-Date -Format u)") | Out-Null
                        $sb.AppendLine("----") | Out-Null
                        foreach ($r in $results) {
                            $sb.AppendLine(("Type: {0}" -f $r.Type)) | Out-Null
                            if ($r.Type -eq "Project") {
                                $sb.AppendLine(("Project: {0} [{1}]" -f $r.Name, $r.Key)) | Out-Null
                                $sb.AppendLine(("Excerpt: {0}" -f $r.MatchExcerpt)) | Out-Null
                            } else {
                                $sb.AppendLine(("Phase: {0}" -f $r.Phase)) | Out-Null
                                $sb.AppendLine(("TaskID: {0} | Status: {1}" -f $r.TaskID, $r.Status)) | Out-Null
                                $sb.AppendLine(("Description: {0}" -f $r.Description)) | Out-Null
                            }
                            $sb.AppendLine("----") | Out-Null
                        }
                        $sb.ToString() | Out-File -FilePath $outFile -Encoding UTF8
                        Write-Host "Exported text summary to $outFile" -ForegroundColor Green
                        Read-Host "Enter to return"
                    }
                    default { }
                }
            }

            "7" {
                # Export Timeline Progress Report (JSON + human-readable text)
                Clear-Host

                # Load timeline from JSON (robust path check)
                if (-not $json.MJAhmad.Timeline) {
                    Write-Host "Timeline section not found in JSON." -ForegroundColor Red
                    Read-Host "Enter to return"
                    break
                }

                $timeline = $json.MJAhmad.Timeline.Timeline
                if (-not $timeline) {
                    Write-Host "No timeline entries found." -ForegroundColor Yellow
                    Read-Host "Enter to return"
                    break
                }

                # Calculate totals (handle missing Status fields)
                $completed  = ($timeline | Where-Object { $_.Status -eq "Completed" }).Count
                $inProgress = ($timeline | Where-Object { $_.Status -eq "In Progress" -or $_.Status -eq "Processing" }).Count
                $pending    = ($timeline | Where-Object { $_.Status -eq "Pending" -or -not $_.Status }).Count
                $total      = $timeline.Count

                $setupPercent = if ($total -gt 0) { [math]::Round(($completed / $total) * 100, 2) } else { 0 }

                # Ensure Show-ProgressBarText function exists before calling
                $barText = ""
                if (Get-Command -Name Show-ProgressBarText -ErrorAction SilentlyContinue) {
                    $barText = Show-ProgressBarText -percent $setupPercent -length 40
                } else {
                    $barText = ("[{0}{1}] {2}%" -f ("#" * [math]::Floor($setupPercent/2)), (" " * (40 - [math]::Floor($setupPercent/2))), $setupPercent)
                }

                # Prepare report object
                $report = [PSCustomObject]@{
                    GeneratedAt  = (Get-Date).ToString("u")
                    Project      = "QuranerFariwala Recovery"
                    TotalSteps   = $total
                    Completed    = $completed
                    InProgress   = $inProgress
                    Pending      = $pending
                    SetupPercent = $setupPercent
                    ProgressBar  = $barText
                    Steps        = $timeline | ForEach-Object {
                        [PSCustomObject]@{
                            Step        = $_.Step
                            Description = $_.Description
                            Status      = $_.Status
                        }
                    }
                }

                # Prepare output directory
                if (-not $reportDir) {
                    $reportDir = Join-Path (Get-Location) "reports"
                }
                if (-not (Test-Path $reportDir)) {
                    New-Item -Path $reportDir -ItemType Directory -Force | Out-Null
                }

                $timestamp = (Get-Date).ToString("yyyyMMdd-HHmmss")
                $jsonOut = Join-Path $reportDir ("timeline-report-{0}.json" -f $timestamp)
                $txtOut  = Join-Path $reportDir ("timeline-report-{0}.txt" -f $timestamp)

                # Export JSON
                $report | ConvertTo-Json -Depth 10 | Out-File -FilePath $jsonOut -Encoding UTF8

                # Build human-readable text report
                $sb = New-Object System.Text.StringBuilder
                $sb.AppendLine("Timeline Progress Report") | Out-Null
                $sb.AppendLine(("Generated: {0}" -f (Get-Date -Format "u"))) | Out-Null
                $sb.AppendLine("") | Out-Null
                $sb.AppendLine(("Project: {0}" -f $report.Project)) | Out-Null
                $sb.AppendLine(("Total Steps: {0}" -f $report.TotalSteps)) | Out-Null
                $sb.AppendLine(("Completed: {0}" -f $report.Completed)) | Out-Null
                $sb.AppendLine(("In Progress: {0}" -f $report.InProgress)) | Out-Null
                $sb.AppendLine(("Pending: {0}" -f $report.Pending)) | Out-Null
                $sb.AppendLine(("Overall Setup: {0}" -f $report.ProgressBar)) | Out-Null
                $sb.AppendLine("") | Out-Null

                foreach ($st in $report.Steps) {
                    $stepLabel = if ($st.Step) { "Step {0}" -f $st.Step } else { "Step" }
                    $sb.AppendLine(("{0}: {1}" -f $stepLabel, ($st.Description -as [string]))) | Out-Null
                    $sb.AppendLine(("  Status: {0}" -f ($st.Status -as [string])) ) | Out-Null
                    $sb.AppendLine("") | Out-Null
                }

                $sb.ToString() | Out-File -FilePath $txtOut -Encoding UTF8

                Write-Host "Timeline report exported to:" -ForegroundColor Green
                Write-Host "  JSON: $jsonOut" -ForegroundColor DarkCyan
                Write-Host "  Text: $txtOut" -ForegroundColor DarkCyan
                Read-Host "Enter to return"
            }

            "8" {
                Write-Host "Exiting MJDocs Explorer..." -ForegroundColor Cyan
                return
            }
            default {
                Write-Host "Invalid choice. Try again." -ForegroundColor Red
                Read-Host "Enter to continue"
            }
        }
    }
}

# --- ---
function CTB {
    param(
        [string]$InputPath = $(Read-Host "Enter input file path"),
        [string]$OutputDir = $(Read-Host "Enter output directory"),
        [string]$Encoding = "utf8"
    )

    # Read file content
    $content = Get-Content -Path $InputPath -Raw -Encoding $Encoding

    # Convert each character to binary
    $binaryData = ($content.ToCharArray() | ForEach-Object {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($_)
        ($bytes | ForEach-Object { [Convert]::ToString($_,2).PadLeft(8,'0') }) -join ' '
    }) -join ' '

    # Ensure output directory exists
    if (!(Test-Path -Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    }

    # Timestamp
    $timestamp = (Get-Date).ToString("HHmmss")

    # Output file path
    $outFile = Join-Path $OutputDir ("binary_output_$timestamp.json")

    # Build JSON object
    $jsonObject = @{
        InputFile = $InputPath
        Encoding  = $Encoding
        Timestamp = $timestamp
        Binary    = $binaryData
    }

    # Save JSON
    $jsonObject | ConvertTo-Json -Depth 3 | Set-Content -Path $outFile -Encoding utf8

    Write-Host "Binary JSON file saved at: $outFile"
}
function CBT {
    param(
        [string]$BinaryFilePath = $(Read-Host "Enter binary file path"),
        [string]$OutputDir = $(Read-Host "Enter output directory"),
        [string]$Encoding = "utf8"
    )

    # Read binary file
    $binaryContent = Get-Content -Path $BinaryFilePath -Raw -Encoding utf8

    # Split and filter out empty strings
    $binaryChunks = $binaryContent.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)

    # Convert binary back to text
    $bytes = $binaryChunks | ForEach-Object { [Convert]::ToInt32($_,2) }
    $restoredText = [System.Text.Encoding]::UTF8.GetString($bytes)

    # Ensure output directory exists
    if (!(Test-Path -Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    }

    # Timestamp
    $timestamp = (Get-Date).ToString("HHmmss")

    # Output file path
    $outFile = Join-Path $OutputDir ("restored_text_$timestamp.txt")

    # Save restored text
    Set-Content -Path $outFile -Value $restoredText -Encoding $Encoding

    Write-Host "Restored text file saved at: $outFile"
}

function BD {
    param (
        [Parameter(Mandatory=$true)]
        [string]$InputDir,

        [Parameter(Mandatory=$true)]
        [string]$OutputDir
    )

    if (-not (Test-Path $InputDir)) {
        Write-Output "Input directory not found: $InputDir"
        return
    }

    # Create timestamp folder (HHmmss)
    $timestamp = (Get-Date).ToString("HHmmss")
    $inputName = Split-Path $InputDir -Leaf
    $targetDir = Join-Path $OutputDir ($inputName + "-" + $timestamp)


    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir | Out-Null
    }

    # Copy files and folders
    Copy-Item -Path $InputDir\* -Destination $targetDir -Recurse -Force

    Write-Output "Backup completed. Files copied to $targetDir"
}
function BF {
    param (
        [Parameter(Mandatory=$true)]
        [string]$InputFile,

        [Parameter(Mandatory=$true)]
        [string]$OutputDir
    )

    if (-not (Test-Path $InputFile)) {
        Write-Output "Input file not found: $InputFile"
        return
    }

    # Create timestamp folder (HHmmss)
    $timestampShort = (Get-Date).ToString("HHmmss")
    $timestampFull  = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss.fffffff")  # পূর্ণ timestamp

    $targetDir = Join-Path $OutputDir $timestampShort
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir | Out-Null
    }

    # Get original file name without extension
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)

    # New file name with timestamp and .txt extension
    $newFileName = "$fileName-$timestampShort.txt"
    $targetFile = Join-Path $targetDir $newFileName

    # Prepare header lines
    $header = @(
        "InputFile = $InputFile",
        "Timestamp = $timestampFull",
        "------"
    )

    # Combine header + original file content
    $content = $header + (Get-Content $InputFile)

    # Save to file
    $content | Out-File $targetFile -Encoding UTF8

    Write-Output "File backed up as $targetFile"
}