import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vyapar_clone/core/constatnts/colors.dart';
import 'package:vyapar_clone/presentation/home_screen/sub_screens/sale_list.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/apply_loan_screen/view/apply_loan_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/back_up_restore/auto_backup_screen/view/auto_backup_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/bank_accounts_screen/view/bank_accounts_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/cash_in_hand_screen/view/cash_in_hand_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/cheque_screen/view/cheque_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/loan_account_screen.dart/view/loan_account_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/manage_companies/view/manage_companies.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/my_online_store/dash_board_screen.dart/view/dash_board_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/my_online_store/manage_orders/view/manage_orders.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/my_online_store/store_report_screen/view/store_report_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/report/view/report_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/sale/delivery_challan_screen/view/delivery_chellan.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/sale/estimate_quotation_screen/view/estimate_details_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/sale/payment_in_screen/sub_screen/payment_in_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/sale/sale_invoice_screen/view/sale_invoice_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/sale/sale_order_screen/view/sale_order_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/sale/sales_return/sub_screens/credit_note/view/credit_note.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/sale/sales_return/view/sales_return.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/utilites/close_financial_year_screen/view/close_financial_year_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/utilites/import_item_screen/view/import_item_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/utilites/import_party_screen/view/import_party_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/utilites/message_screen/view/message_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/sub_screens/utilites/recycle_bin_screen/view/recycle_bin_screen.dart';
import 'package:vyapar_clone/presentation/menu_screen/widget/custom_page_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<void> _openCalculator() async {
    const String calculatorUrl =
        'calculator://'; // Common URL scheme for calculators

    // Try to launch the calculator app using the URL
    if (await canLaunch(calculatorUrl)) {
      await launch(calculatorUrl);
    } else {
      // If the URL scheme does not work, try using the Android Intent
      try {
        await launch(
            'intent://calculator#Intent;scheme=android.intent.action.VIEW;end');
      } catch (e) {
        _showSnackbar('Could not open the calculator app.');
      }
    }
  }

  // Function to show the custom Snackbar-like message
  void _showSnackbar(String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.h, // Positioning from the bottom
        left: 10.w,
        // Center horizontally
        right: 10.w,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay
    overlay.insert(overlayEntry);

    // Remove the overlay after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

// Function to share content
  void _shareContent(String content) {
    Share.share(content, subject: 'Backup Data');
  }

  Future<void> _openFileManager() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      String filePath = result.files.single.path!;
      print('Selected file: $filePath');
      // Implement your backup restoration logic here
    } else {
      print('No file selected');
    }
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Verification Result',
              style: TextStyle(
                  color: Colorconst.cBlack,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold)),
          content: Text(
            'There was no problem found during \n'
            'verification of your file.your all data is\n'
            'matching.',
            style: TextStyle(color: Colorconst.cBlack, fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK',
                  style: TextStyle(color: Colorconst.cBlue, fontSize: 14.sp)),
            ),
          ],
        );
      },
    );
  }

  void _showCustomPopup(
      BuildContext context, List<Map<String, dynamic>> items) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close),
                      ),
                      const SizedBox(width: 8),
                      // Text(title,
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  buildIconGrid(items.map((item) {
                    return iconWithLabel(
                        item['icon'], item['label'], item['onTap']);
                  }).toList()),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        var curve = Curves.easeInOut;
        var scale = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: anim1,
          curve: curve,
        ));
        var opacity =
            Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: anim1,
          curve: curve,
        ));

        return ScaleTransition(
          scale: scale,
          child: FadeTransition(
            opacity: opacity,
            child: child,
          ),
        );
      },
    );
  }

  void _showSalePopup(BuildContext context) {
    _showCustomPopup(context, [
      {
        'icon': Icons.payment,
        'label': 'Payment-In',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentInScreen()));
        }
      },
      {
        'icon': Icons.assignment_return,
        'label': 'Sale Return',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SaleReturnScreen()));
        }
      },
      {
        'icon': Icons.local_shipping,
        'label': 'Delivery Challan',
        'onTap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeliveryChallanDetails()));
        }
      },
      {
        'icon': Icons.receipt,
        'label': 'Estimate/Quotation',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EstimateDetailsScreen()));
        }
      },
      {
        'icon': Icons.receipt_long,
        'label': 'Sale Invoice',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SaleInvoistListScreen()));
        }
      },
      {
        'icon': Icons.add_shopping_cart,
        'label': 'Sale Order',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SaleOrderScreen()));
        }
      },
    ]);
  }

  void _showPurchasePopup(BuildContext context) {
    _showCustomPopup(context, [
      {
        'icon': Icons.shopping_cart,
        'label': 'Purchase',
        'onTap': () {/*  onTap action */}
      },
      {
        'icon': Icons.payment_outlined,
        'label': 'Payment-Out',
        'onTap': () {/*  onTap action */}
      },
      {
        'icon': Icons.assignment_return,
        'label': 'Purchase Return',
        'onTap': () {/*  onTap action */}
      },
      {
        'icon': Icons.receipt,
        'label': 'Purchase Order',
        'onTap': () {/*  onTap action */}
      },
    ]);
  }

  void _showOnlineShopPopup(BuildContext context) {
    _showCustomPopup(context, [
      {
        'icon': Icons.dashboard,
        'label': 'DashBoard',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DashBoardScreen(),
            ),
          );
        }
      },
      {
        'icon': Icons.production_quantity_limits_sharp,
        'label': 'Manage Item',
        'onTap': () {}
      },
      {
        'icon': Icons.sell,
        'label': 'Manage Orders',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManageOrders(),
            ),
          );
        }
      },
      {
        'icon': Icons.report_gmailerrorred,
        'label': 'Store Reports',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StoreReportScreen(),
            ),
          );
        }
      },
    ]);
  }

  void _showBackupRestorePopup(BuildContext context) {
    _showCustomPopup(context, [
      {
        'icon': Icons.backup,
        'label': 'Auto Backup',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AutoBackupSettings()));
        }
      },
      {
        'icon': Icons.save_alt,
        'label': 'Backup to Phone',
        'onTap': () {
          _showSnackbar('Data has been backed up in Documents/file path');
        }
      },
      {
        'icon': Icons.email,
        'label': 'Backup to E-mail',
        'onTap': () {
          _shareContent('Data has been backed up.');
        }
      },
      {
        'icon': Icons.restore,
        'label': 'Restore Backup',
        'onTap': _openFileManager
      },
    ]);
  }

  void _showUtilitiesPopup(BuildContext context) {
    _showCustomPopup(context, [
      {
        'icon': Icons.check,
        'label': 'Verify my data',
        'onTap': _showVerificationDialog,
      },
      {
        'icon': Icons.calculate,
        'label': 'Open Calculator',
        'onTap': _openCalculator,
      },
      {
        'icon': Icons.import_contacts,
        'label': 'Import items',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportItemsScreen()));
        }
      },
      {
        'icon': Icons.group_add,
        'label': 'Import Parties',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImportPartyScreen()));
        }
      },
      {
        'icon': Icons.delete,
        'label': 'Recycle Bin',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RecycleBinScreen()));
        }
      },
      {
        'icon': Icons.close,
        'label': 'Close Financial Year',
        'onTap': () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VyaparScreen()));
        }
      },
      {
        'icon': Icons.message,
        'label': 'Messages',
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MessageScreen()));
        }
      },
    ]);
  }

  void _showHelpSupportPopup(BuildContext context) {
    _showCustomPopup(context, [
      {
        'icon': Icons.phone,
        'label': 'Customer Care',
        'onTap': () {/*  onTap action */}
      },
      {
        'icon': Icons.video_library,
        'label': 'Tutorials',
        'onTap': () {/*  onTap action */}
      },
      {
        'icon': Icons.support_agent,
        'label': 'Remote Support',
        'onTap': () {/*  onTap action */}
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.home_outlined,
          color: Colors.blue,
        ),
        title: const Text(
          'XianInfoTech',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
        ],
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomPageView(),
            const SizedBox(height: 10),
            buildSummaryCard(),
            const SizedBox(height: 10),
            buildSection('Create', [
              buildGridItem(Icons.blinds_closed_rounded, 'Invoice', () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SaleListScreen()));
              }),
              buildGridItem(Icons.inventory_2_outlined, 'Quotation', () {}),
              buildGridItem(Icons.timelapse_outlined, 'Delivery Challan', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeliveryChallanDetails()));
              }),
              buildGridItem(Icons.auto_graph_sharp, 'Credit Note', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreditNoteScreen()));
              }),
              buildGridItem(
                  Icons.business_center_outlined, 'Purchase Order', () {}),
              buildGridItem(Icons.card_membership, 'Pro Forma Invoice', () {}),
            ]),
            const SizedBox(height: 10),
            buildSection('My Business', [
              buildGridItem(Icons.currency_rupee_sharp, 'Sale', () {
                _showSalePopup(context);
              }),
              buildGridItem(Icons.shopping_cart_outlined, 'Purchase', () {
                _showPurchasePopup(context);
              }),
              buildGridItem(Icons.note_alt_outlined, 'Expenses', () {}),
              buildGridItem(Icons.home_outlined, 'My Online Store', () {
                _showOnlineShopPopup(context);
              }),
              buildGridItem(Icons.note_outlined, 'Report', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportScreen()));
              }),
            ]),
            const SizedBox(height: 10),
            buildSection('Quick Access', [
              buildGridItem(Icons.blinds_closed_rounded, 'E-Way Bill', () {}),
              buildGridItem(Icons.inventory_2_outlined, 'E-Invoice', () {}),
              buildGridItem(
                  Icons.timelapse_outlined, 'Payment Timeline', () {}),
              buildGridItem(Icons.auto_graph_sharp, 'Insights', () {}),
              buildGridItem(
                  Icons.business_center_outlined, 'Business Card', () {}),
              buildGridItem(Icons.card_membership, 'Greetings', () {}),
              buildGridItem(
                  Icons.business_center_outlined, 'Invoice Templates', () {}),
              buildGridItem(
                  Icons.document_scanner_outlined, 'Document Settings', () {}),
            ]),
            const SizedBox(height: 10),
            buildSection('Cash & Bank', [
              buildGridItem(Icons.account_balance_outlined, 'Bank Accounts',
                  () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BankAccountsPage()));
              }),
              buildGridItem(
                  Icons.account_balance_wallet_outlined, 'Cash In-Hand', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CashInHand()));
              }),
              buildGridItem(Icons.note, 'Cheques', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cheques()));
              }),
              buildGridItem(Icons.playlist_add_circle_outlined, 'Loan Account',
                  () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoanAccountPage()));
              }),
              buildGridItem(Icons.currency_rupee_outlined, 'Apply Loan', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ApplyLoanPage()));
              }),
            ]),
            const SizedBox(height: 10),
            buildSection('Important Utilities', [
              buildGridItem(Icons.sync, 'Sync & Share', () {}),
              buildGridItem(Icons.manage_history_sharp, 'Manage Companies', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManageCompanies()));
              }),
              buildGridItem(
                  Icons.settings_backup_restore_outlined, 'Backup/Restore', () {
                _showBackupRestorePopup(context);
              }),
              buildGridItem(Icons.shopping_bag_outlined, 'Utilities', () {
                _showUtilitiesPopup(context);
              }),
            ]),
            const SizedBox(height: 10),
            buildSection('Others', [
              buildGridItem(
                  Icons.account_balance_outlined, 'Vyapar Premium', () {}),
              buildGridItem(Icons.account_balance_wallet_outlined,
                  'Get Desktop Billing Software', () {}),
              buildGridItem(
                  Icons.view_comfortable_rounded, 'Other Products', () {}),
              buildGridItem(Icons.phone_enabled, 'Greeting & Offers', () {}),
              buildGridItem(Icons.settings_outlined, 'Settings', () {}),
            ]),
          ],
        ),
      ),
    );
  }
}

Widget buildSummaryCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('This Year',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colorconst.cBlack)),
            Text('View Bill',
                style: TextStyle(
                  color: Colors.blue,
                )),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Sales',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colorconst.cBlack)),
                Text('₹0.00',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colorconst.cBlack)),
              ],
            ),
            VerticalDivider(color: Colors.grey, thickness: 1),
            Column(
              children: [
                Text('Purchases',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colorconst.cBlack)),
                Text('₹0.00',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colorconst.cBlack)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildSection(String title, List<Widget> gridItems) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colorconst.cBlack)),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          children: gridItems,
        ),
      ],
    ),
  );
}

Widget buildGridItem(IconData icon, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Icon(
          icon,
          size: 25,
          color: Colors.blue,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colorconst.cBlack),
    ),
  );
}

Widget buildIconGrid(List<Widget> children) {
  return GridView.count(
    crossAxisCount: 3,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 15,
    // mainAxisSpacing: 5,
    children: children,
  );
}

Widget iconWithLabel(IconData icon, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, color: Colors.black),
        ),
      ],
    ),
  );
}
