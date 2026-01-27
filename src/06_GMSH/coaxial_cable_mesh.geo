// Gmsh project created on Tue Jan 27 16:49:30 2026
SetFactory("OpenCASCADE");

s = 5.0;

//+
Point(1) = {0, 0.5, 0, 1.0};
//+
Point(2) = {0, -0.5, 0, 1.0};
//+
Point(3) = {-0.5, -0, 0, 1.0};
//+
Point(4) = {0.5, 0, 0, 1.0};

Point(5) = {0, 0, 0, 1.0};
//+
Circle(1) = {1, 5, 4};
//+
Circle(2) = {4, 5, 2};
//+
Circle(3) = {2, 5, 3};
//+\
Circle(4) = {3, 5, 1};

Point(6) = {0, 0.5*s, 0, 1.0};
//+
Point(7) = {0, -0.5*s, 0, 1.0};
//+
Point(8) = {-0.5*s, -0, 0, 1.0};
//+
Point(9) = {0.5*s, 0, 0, 1.0};

//+
Circle(5) = {6, 5, 9};
//+
Circle(6) = {9, 5, 7};
//+
Circle(7) = {7, 5, 8};
//+
Circle(8) = {8, 5, 6};
//+
Line(9) = {8, 3};
//+
Line(10) = {1, 6};
//+
Line(11) = {4, 9};
//+
Line(12) = {2, 7};
//+
//+
Curve Loop(1) = {8, -10, -4, -9};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {5, -11, -1, 10};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {11, 6, -12, -2};
//+
Plane Surface(3) = {3};
//+
Curve Loop(4) = {12, 7, 9, -3};
//+
Plane Surface(4) = {4};
//+

Transfinite Curve {8, 5, 6, 7, 4, 1, 2, 3} = 50 Using Progression 1;

Transfinite Curve {9,-10,-11,-12} = 25 Using Progression 1.2;

//+
Transfinite Surface {1};
//+
Transfinite Surface {2};
//+
Transfinite Surface {3};
//+
Transfinite Surface {4};
