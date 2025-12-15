lms = 0.05;

Point(1) = {-1, -1, 0, lms};

Point(2) = {0, -1, 0, lms};

Point(3) = {0, 0, 0, lms};

Point(4) = {-1, 0, 0, lms};

//+
Line(1) = {1, 2};
//+
Line(2) = {2, 3};
//+
Line(3) = {3, 4};
//+
Line(4) = {4, 1};

//+
Curve Loop(1) = {3, 4, 1, 2};
//+
Plane Surface(1) = {1};
//+

Physical Curve("S", 5) = {1};
//+
Physical Curve("E", 6) = {2};
//+
Physical Curve("N", 7) = {3};
//+
Physical Curve("W", 8) = {4};
//+
Physical Surface("S1", 9) = {1};
