import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children: [          
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("Images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFF5F5F5).withOpacity(0.7),  
                  const Color(0xFFFAFAFA).withOpacity(0.7),  
                  const Color(0xFFFFF8E1).withOpacity(0.7),  
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              Container(
                // width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                // decoration: BoxDecoration(
                //   color: Colors.white.withOpacity(0.95),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black.withOpacity(0.1),
                //       blurRadius: 10,
                //       offset: const Offset(0, 3),
                //     ),
                //   ],
                // ),
                child: const Text(
                  "FESTHUB",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 64.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0,4),
                        blurRadius: 8,
                      )
                    ]
                  ),
                ),
              ),

              const SizedBox(height: 144.0),              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Text(
                      "All your favourite events",
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 32.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "At One place",
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontSize: 36.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      "Explore, book, gather your friends and experience unforgettable moments effortlessly!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87.withOpacity(0.8),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 45.0),
                    
                    
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.shade400,
                            Colors.orange.shade300,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            // Add sign-in logic here
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(
                                  "Images/google.png",
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              const Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}