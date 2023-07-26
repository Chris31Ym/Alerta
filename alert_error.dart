import 'package:flutter/material.dart';

class AlertError extends StatelessWidget {
  const AlertError({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: SizedBox(
          height: 200,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white70,
                  child: const Icon(Icons.error_outlined, size: 60),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.red,
                  child: SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const Text(
                            '¡Atento!, Estas Reprobado :(',
                            style: TextStyle(color: Colors.black87),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Entendido',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
