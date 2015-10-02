//!OpenSCAD




tubeRadius = 40;
innerTubeRaduis = 15;
numTubes = 7;
innerNumTubes = 3;
cupHeight = 137;
tubeOuterDiameter = 0;
tubeConsolidatorRadius = 41;
tubeOffset = 7;

union(){
  translate([-219, 0, 0]){
    for (j = [1 : abs(1) : 5]) {
      translate([(j * 73), -60, 100]){
        union(){
          translate([0, 0, 0]){
            cylinder(r1=14.5, r2=14.5, h=50.8, center=false);
          }
          translate([0, 0, -15]){
            cube([45.72, 33, 30], center=true);
          }
          translate([0, tubeOffset, -42]){
            cylinder(r1=3.175, r2=3.175, h=12.7, center=false);
          }
          translate([0, (tubeOffset * -1), -42]){
            cylinder(r1=3.175, r2=3.175, h=12.7, center=false);
          }
          translate([0, -11.5, 6]){
            cube([71, 10, 10], center=true);
          }
          translate([0, -11.5, 40]){
            cube([71, 10, 10], center=true);
          }
        }
      }
    }
  }
  translate([0, -77, 100]){
    cube([365, 2, 100], center=true);
  }
}
difference(){
  translate([0, 0, 2]){
    cube([200, 120, 2.5], center=true);
  }
  rotate([0, 0, 45]){
    for (i = [1 : abs(1) : numTubes]) {
      translate([(tubeRadius * cos((i * (360 / numTubes)))), (tubeRadius * sin((i * (360 / numTubes)))), 0]){
        cylinder(r1=9.5, r2=9.5, h=10, center=false);
      }
    }
  }
  for (i = [1 : abs(1) : innerNumTubes]) {
    translate([(innerTubeRaduis * cos((i * (360 / innerNumTubes)))), (innerTubeRaduis * sin((i * (360 / innerNumTubes)))), 0]){
      cylinder(r1=9.5, r2=9.5, h=10, center=false);
    }
  }
}
//1;

translate([0, 0, -40]){
  difference(){
    cylinder(r1=tubeConsolidatorRadius, r2=tubeConsolidatorRadius, h=1, center=true);
    rotate([0, 0, 45]){
      for (i = [1 : abs(1) : numTubes]) {
        translate([((tubeRadius - 10) * cos((i * (360 / numTubes)))), ((tubeRadius - 10) * sin((i * (360 / numTubes)))), 0]){
          cylinder(r1=9.5, r2=9.5, h=10, center=true);
        }
      }
    }
    for (i = [1 : abs(1) : innerNumTubes]) {
      translate([((innerTubeRaduis - 26) * cos((i * (360 / innerNumTubes)))), ((innerTubeRaduis - 26) * sin((i * (360 / innerNumTubes)))), 0]){
        cylinder(r1=9.5, r2=9.5, h=10, center=true);
      }
    }
  }
}
union(){
  translate([-219, 50, 0]){
    for (j = [1 : abs(1) : 5]) {
      translate([(j * 73), -60, 100]){
        union(){
          translate([0, 0, 0]){
            cylinder(r1=14.5, r2=14.5, h=50.8, center=false);
          }
          translate([0, 0, -15]){
            cube([45.72, 33, 30], center=true);
          }
          translate([0, tubeOffset, -42]){
            cylinder(r1=3.175, r2=3.175, h=12.7, center=false);
          }
          translate([0, (tubeOffset * -1), -42]){
            cylinder(r1=3.175, r2=3.175, h=12.7, center=false);
          }
          translate([0, -11.5, 6]){
            cube([71, 10, 10], center=true);
          }
          translate([0, -11.5, 40]){
            cube([71, 10, 10], center=true);
          }
        }
      }
    }
  }
  translate([0, -27, 100]){
    cube([365, 2, 100], center=true);
  }
}
translate([0, 0, (cupHeight * -1)]){
  cylinder(r1=30.5, r2=44.5, h=cupHeight, center=true);
}