/*
Copyright 2015 Phillip Showers

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

$fn=50;
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
pumpBracketHoleRadius = 1.5875;
//unit dimensions
barbotDepth = 152;
barbotHeight = 358;
wallThickness = 6.5;

//options
showPumps = false;

module pump() {
    color("lightBlue",0.3)
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

module pumpBracketHoles(){
    union(){
      translate([(pumpBracketWidth/2)-5, -20, 4+pumpBracketHoleRadius]){
          rotate([90,0,0])
            cylinder(r1=pumpBracketHoleRadius, r2=pumpBracketHoleRadius, h=20, center=true);
      }
      translate([-(pumpBracketWidth/2)+5, -20, 4+pumpBracketHoleRadius]){
          rotate([90,0,0])
            cylinder(r1=pumpBracketHoleRadius, r2=pumpBracketHoleRadius, h=20, center=true);
      }
      translate([-(pumpBracketWidth/2)+5, -20, 38+pumpBracketHoleRadius]){
          rotate([90,0,0])
            cylinder(r1=pumpBracketHoleRadius, r2=pumpBracketHoleRadius, h=20, center=true);
      }
      translate([(pumpBracketWidth/2)-5, -20, 38+pumpBracketHoleRadius]){
          rotate([90,0,0])
            cylinder(r1=pumpBracketHoleRadius, r2=pumpBracketHoleRadius, h=20, center=true);
      }
  }
}
    
module pumpBracket() {
    union(){
        difference(){
          translate([0, -pumpBracketWidth-(wallThickness*1.45), 0])
            cube([(pumpBracketWidth+4)*numPumps, wallThickness, 100], center=true);
            
          translate([-219, 0, 0]){
            for (j = [1 : abs(1) : numPumps]) {
              translate([(j * (pumpBracketWidth+2)), -60, 0]){
                pump();
                pumpBracketHoles();
              }
            }//for
          }
        }
        if(showPumps)
        {
            translate([-219, 0, 0]){
            for (j = [1 : abs(1) : numPumps]) {
              translate([(j * (pumpBracketWidth+2)), -60, 0])
                pump();
              
                }
            }
        }
        
        //tabs
        translate([(((pumpBracketWidth+4)*numPumps)/2)+(wallThickness/2),-pumpBracketWidth-(wallThickness*1.45),0])
            cube([wallThickness, wallThickness, wallThickness*6], center=true);
        
        translate([-(((pumpBracketWidth+4)*numPumps)/2)-(wallThickness/2),-pumpBracketWidth-(wallThickness*1.45),0])
            cube([wallThickness, wallThickness, wallThickness*6], center=true);
        
    }
}


module tubeCondensor() {
    union(){
        difference(){
          translate([0, 0, 2]){
            cube([(pumpBracketWidth+4)*numPumps, barbotDepth, wallThickness], center=true);
          }
          rotate([0, 0, 45]){
            for (i = [1 : abs(1) : numTubes]) {
              translate([(tubeRadius * cos((i * (360 / numTubes)))),
                         (tubeRadius * sin((i * (360 / numTubes)))), 0]){
                cylinder(r1=tubeOR, r2=tubeOR, h=100, center=true);
              }
            }
          }
          for (i = [1 : abs(1) : innerNumTubes]) {
            translate([(innerTubeRadius * cos((i * (360 / innerNumTubes)))),
                       (innerTubeRadius * sin((i * (360 / innerNumTubes)))), 0]){
              cylinder(r1=tubeOR, r2=tubeOR, h=100, center=true);
            }
          }
        }
        //tabs
        translate([(((pumpBracketWidth+4)*numPumps)/2)+(wallThickness/2), barbotDepth/3, 2])
            cube([wallThickness, wallThickness*4, wallThickness], center=true);
        translate([(((pumpBracketWidth+4)*numPumps)/2)+(wallThickness/2), -barbotDepth/3, 2])
            cube([wallThickness, wallThickness*4, wallThickness], center=true);
        translate([-(((pumpBracketWidth+4)*numPumps)/2)-(wallThickness/2), barbotDepth/3, 2])
            cube([wallThickness, wallThickness*4, wallThickness], center=true);
        translate([-(((pumpBracketWidth+4)*numPumps)/2)-(wallThickness/2), -barbotDepth/3, 2])
            cube([wallThickness, wallThickness*4, wallThickness], center=true);
        //back wall
        translate([0,(-barbotDepth/2)-(wallThickness/2),2])
            cube([wallThickness*4, wallThickness, wallThickness], center=true);
        translate([(pumpBracketWidth+4)*numPumps/3,(-barbotDepth/2)-(wallThickness/2),2])
            cube([wallThickness*4, wallThickness, wallThickness], center=true);
        translate([-(pumpBracketWidth+4)*numPumps/3,(-barbotDepth/2)-(wallThickness/2),2])
            cube([wallThickness*4, wallThickness, wallThickness], center=true);
    }
}


module roundTubeCondensor() {
    translate([0, 0, -40]){
      difference(){
        cylinder(r1=tubeConsolidatorRadius, 
                 r2=tubeConsolidatorRadius, h=wallThickness, center=true);
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
    color("red", 0.3)
    translate([0, 0, (cupHeight * -1)]){
      cylinder(r1=30.5, r2=44.5, h=cupHeight, center=true);
    }
}



module sidePart(){
    hull(){
        translate([0, -pumpBracketWidth-6.5+(barbotDepth/2)-(wallThickness/2), (-cupHeight*1.5)])
            cube([wallThickness, barbotDepth+(wallThickness), 2], center=true);//*/
        translate([0, -pumpBracketWidth-6.5+(barbotDepth/2)-(wallThickness/2), 0])
            cube([wallThickness, barbotDepth+(wallThickness), 2], center=true);
        translate([0, -pumpBracketWidth+30-(wallThickness/2), 150])
            cube([wallThickness, barbotDepth/2+(wallThickness/2), 2], center=true);
    }
}

module bottomPart(){
    union(){
    translate([0, -pumpBracketWidth-6.5+(barbotDepth/2), (-cupHeight*1.5)])
        cube([(pumpBracketWidth+4)*numPumps, barbotDepth, wallThickness], center=true);
    
        //tabs
        translate([(((pumpBracketWidth+4)*numPumps)/2)+(wallThickness/2), barbotDepth/3, (-cupHeight*1.5)])
            cube([wallThickness, wallThickness*4, wallThickness], center=true);
        translate([(((pumpBracketWidth+4)*numPumps)/2)+(wallThickness/2), -barbotDepth/3, (-cupHeight*1.5)])
            cube([wallThickness, wallThickness*4, wallThickness], center=true);
        translate([-(((pumpBracketWidth+4)*numPumps)/2)-(wallThickness/2), barbotDepth/3, (-cupHeight*1.5)])
            cube([wallThickness, wallThickness*4, wallThickness], center=true);
        translate([-(((pumpBracketWidth+4)*numPumps)/2)-(wallThickness/2), -barbotDepth/3, (-cupHeight*1.5)])
            cube([wallThickness, wallThickness*4, wallThickness], center=true);
        
        translate([0,(-barbotDepth/2)-(wallThickness/2)-1.5,(-cupHeight*1.5)-0.1])
            cube([wallThickness*4, wallThickness, wallThickness], center=true);
        translate([(pumpBracketWidth+4)*numPumps/3,(-barbotDepth/2)-(wallThickness/2)-1.5,(-cupHeight*1.5)-0.1])
            cube([wallThickness*4, wallThickness, wallThickness], center=true);
        translate([-(pumpBracketWidth+4)*numPumps/3,(-barbotDepth/2)-(wallThickness/2)-1.5,(-cupHeight*1.5)-0.1])
            cube([wallThickness*4, wallThickness, wallThickness], center=true);
        
    }
}



module backPart(){
    union(){
        difference()
        {
            cube([(pumpBracketWidth+4)*numPumps, wallThickness, barbotHeight], center=true);
            translate([-219, -(-(barbotDepth/2)-2), 100+27.5]){
                for (j = [1 : abs(1) : numPumps]) {
                    translate([(j * (pumpBracketWidth+2)), -60, 0]){
                        pumpBracketHoles();
                    }
                }//for
            }
            
            translate([(-(pumpBracketWidth*3)), 0, 0]){
                for (y = [1 : abs(1) : 2]) {
                for (x = [1 : abs(1) : numPumps]) 
                    rotate([90,0,0])
                        translate([(x * (pumpBracketWidth+2)), (y*-15)+36*2, 0])
                            cylinder(r1=4.75, r2=4.75, h=50, center=true);
            }
            }
            
        }
        
        //tabs
        translate([(((pumpBracketWidth+4)*numPumps)/2)+(wallThickness/2),0,barbotHeight/3])
            cube([wallThickness, wallThickness, wallThickness*4], center=true);
        translate([(((pumpBracketWidth+4)*numPumps)/2)+(wallThickness/2),0,0])
            cube([wallThickness, wallThickness, wallThickness*4], center=true);
        translate([(((pumpBracketWidth+4)*numPumps)/2)+(wallThickness/2),0,-barbotHeight/3])
            cube([wallThickness, wallThickness, wallThickness*4], center=true);
        
        translate([-(((pumpBracketWidth+4)*numPumps)/2)-(wallThickness/2),0,barbotHeight/3])
            cube([wallThickness, wallThickness, wallThickness*4], center=true);
        translate([-(((pumpBracketWidth+4)*numPumps)/2)-(wallThickness/2),0,0])
            cube([wallThickness, wallThickness, wallThickness*4], center=true);
        translate([-(((pumpBracketWidth+4)*numPumps)/2)-(wallThickness/2),0,-barbotHeight/3])
            cube([wallThickness, wallThickness, wallThickness*4], center=true);
    }
}
// FINAL MODULES
module fullBarBot(){
    soloCup();
    roundTubeCondensor();
    color("green", 1)
    translate([0, -1.5, 0])
        tubeCondensor();
    translate([0, 50+(wallThickness/2), 97.75])
        pumpBracket();//*/
    color("green", 1)
    bottomPart();
    translate([wallThickness+(((pumpBracketWidth+(wallThickness/2))*numPumps-2)/2)-0.4, 0, -2.25])
        sidePart();//*/
    translate([-wallThickness+(((pumpBracketWidth+(wallThickness/2))*numPumps-2)/-2)+0.4, 0, -2.25])
        sidePart();//*/
    color("Yellow", 1)
    translate([0, -(barbotDepth/2)-(wallThickness/2)-1.5, -29.75])
        backPart();//*/
}

module dxfBottomPart(){
    projection(cut = false){
        bottomPart();
    }
}
module dxfTubeCondensor(){
    projection(cut = false){
        tubeCondensor();
    }
}
module dxfBackPart(){
    projection(cut = false)
    {
        rotate([90, 0, 0])
        backPart();
    }
}

module dxfSidePart(){
    projection(cut = false)
    {
        rotate([0, 90, 0]){
            difference(){
                translate([wallThickness+(((pumpBracketWidth+(wallThickness/2))*numPumps-2)/2)-0.4, 0, -2.25])
                    sidePart();//*/
                translate([0, -1.5, 0])
                    tubeCondensor();
                translate([0, 50+(wallThickness/2), 97.75])
                    pumpBracket();//*/
                bottomPart();
                translate([0, -(barbotDepth/2)-(wallThickness/2)-1.5, -29.75])
                    backPart();//*/
            }
        }
    }
}

module dxfPumpBracket(){
    projection(cut = false){
        rotate([90, 0, 0])
            pumpBracket();
    }
}

module dxfRoundTubeCondensor(){
    projection(cut = false)
        roundTubeCondensor();
}

// module calls
fullBarBot();
//dxfBottomPart();
//dxfTubeCondensor();
//dxfBackPart();
//dxfSidePart();
//dxfPumpBracket();
//dxfRoundTubeCondensor();
