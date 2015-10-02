tubeRadius = 20;
innerTubeRadius = 7;
numTubes = 7;
tubeOR = 4.75;
innerNumTubes = 3;
cupHeight = 137;
tubeConsolidatorRadius = 24;
tubeOffset = 7;
//pump
pumpBracketWidth = 71;
numPumps = 5;
//unit dimensions
barbotDepth = 152;
barbotHeight = 358;

module pump() {
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
        cube([pumpBracketWidth, 10, 10], center=true);
      }
      translate([0, -11.5, 40]){
        cube([pumpBracketWidth, 10, 10], center=true);
      }
    }
}
    
module pumpBracket() {
        union(){
          translate([-219, 0, 0]){
            for (j = [1 : abs(1) : numPumps]) {
              translate([(j * (pumpBracketWidth+2)), -60, 0]){
                pump();
              }
            }
          }
          translate([0, -pumpBracketWidth-6.5, 0]){
            cube([(pumpBracketWidth+4)*numPumps, 2, 100], center=true);
          }
        }
}


module tubeCondensor() {
    difference(){
      translate([0, 0, 2]){
        cube([(pumpBracketWidth+4)*numPumps, barbotDepth, 2.5], center=true);
      }
      rotate([0, 0, 45]){
        for (i = [1 : abs(1) : numTubes]) {
          translate([(tubeRadius * cos((i * (360 / numTubes)))),
                     (tubeRadius * sin((i * (360 / numTubes)))), 0]){
            cylinder(r1=tubeOR, r2=tubeOR, h=10, center=false);
          }
        }
      }
      for (i = [1 : abs(1) : innerNumTubes]) {
        translate([(innerTubeRadius * cos((i * (360 / innerNumTubes)))),
                   (innerTubeRadius * sin((i * (360 / innerNumTubes)))), 0]){
          cylinder(r1=tubeOR, r2=tubeOR, h=10, center=false);
        }
      }
    }
}


module roundTubeCondensor() {
    translate([0, 0, -40]){
      difference(){
        cylinder(r1=tubeConsolidatorRadius, 
                 r2=tubeConsolidatorRadius, h=1, center=true);
        rotate([0, 0, 45]){
          for (i = [1 : abs(1) : numTubes]) {
            translate([((tubeRadius -4) * cos((i * (360 / numTubes)))),
                       ((tubeRadius -4) * sin((i * (360 / numTubes)))), 0]){
              cylinder(r1=tubeOR, r2=tubeOR, h=10, center=true);
            }
          }
        }//*/
        for (i = [1 : abs(1) : innerNumTubes]) {
          translate([((innerTubeRadius-1) * cos((i * (360 / innerNumTubes)))),
                     ((innerTubeRadius-1) * sin((i * (360 / innerNumTubes)))), 
                       0]){
            cylinder(r1=tubeOR, r2=tubeOR, h=10, center=true);
          }
        }
      }
    }
}


module soloCup() {    
    translate([0, 0, (cupHeight * -1)]){
      cylinder(r1=30.5, r2=44.5, h=cupHeight, center=true);
    }
}



module sidePart(){
    hull(){
        translate([0, -pumpBracketWidth-6.5+(barbotDepth/2), (-cupHeight*1.5)])
            cube([2, barbotDepth, 2], center=true);
        translate([0, -pumpBracketWidth-6.5+(barbotDepth/2), 0])
            cube([2, barbotDepth, 2], center=true);
        translate([0, -pumpBracketWidth+30, 150])
            cube([2, barbotDepth/2, 2], center=true);
    }
}

module bottomPart(){
    translate([0, -pumpBracketWidth-6.5+(barbotDepth/2), (-cupHeight*1.5)])
        cube([(pumpBracketWidth+4)*numPumps, barbotDepth, 2], center=true);
}



module backPart(){
    translate([0, -(barbotDepth/2)-2, -27.5])
        difference()
        {
            cube([(pumpBracketWidth+4)*numPumps, 2, barbotHeight], center=true);
            translate([(-(pumpBracketWidth*3)), 0, 0])
                for (y = [1 : abs(1) : 2]) 
                for (x = [1 : abs(1) : numPumps]) 
                    rotate([90,0,0])
                        translate([(x * (pumpBracketWidth+2)), (y*-15)+36*2, 0])
                            cylinder(r1=4.75, r2=4.75, h=50, center=true);
        }
        //translate([0, -(barbotDepth/2)-2, 27.5])
        //rotate([90,0,0]) cylinder(r1=4.75, r2=4.75, h=50, center=true);
        
}
// module calls

soloCup();
roundTubeCondensor();
tubeCondensor();
translate([0, 0, 100])
    pumpBracket();
translate([0, 50, 100])
    pumpBracket();

bottomPart();
translate([((pumpBracketWidth+4)*numPumps)/2, 0, 0])
    sidePart();
translate([((pumpBracketWidth+4)*numPumps)/-2, 0, 0])
    sidePart();
backPart();