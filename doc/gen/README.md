# PCB

Board size: 37.5x19.0 mm (1.48x0.75 inches)

- This is the size of the rectangle that contains the board
- Thickness: 1.6 mm (63 mils)
- Material: FR4
- Finish: None
- Layers: 2
- Copper thickness: 35 µm

Solder mask: TOP / BOTTOM

- Color: Green

Silk screen: TOP / BOTTOM

- Color: White


Stackup:

| Name                 | Type                 | Color            | Thickness | Material        | Epsilon_r | Loss tangent |
|----------------------|----------------------|------------------|-----------|-----------------|-----------|--------------|
| F.SilkS              | Top Silk Screen      |                  |           |                 |           |              |
| F.Paste              | Top Solder Paste     |                  |           |                 |           |              |
| F.Mask               | Top Solder Mask      | Green            |        10 |                 |           |              |
| F.Cu                 | copper               |                  |        35 |                 |           |              |
| dielectric 1         | core                 |                  |      1510 | FR4             |       4.5 |        0.020 |
| B.Cu                 | copper               |                  |        35 |                 |           |              |
| B.Mask               | Bottom Solder Mask   | Green            |        10 |                 |           |              |
| B.Paste              | Bottom Solder Paste  |                  |           |                 |           |              |
| B.SilkS              | Bottom Silk Screen   |                  |           |                 |           |              |

# Important sizes

Clearance: 0.2 mm (8 mils)

Track width: 0.4 mm (16 mils)

- By design rules: 0.15 mm (6 mils)

Drill: 0.5 mm (20 mils)

- Vias: 0.5 mm (20 mils) [Design: 0.4 mm (16 mils)]
- Pads: 1.1 mm (43 mils)
- The above values are real drill sizes, they add 0.1 mm (4 mils) to plated holes (PTH)

Via: 0.8/0.4 mm (31/16 mils)

- By design rules: 0.4/0.3 mm (16/12 mils)
- Micro via: no [0.2/0.1 mm (8/4 mils)]
- Buried/blind via: no
- Total: 63 (thru: 63 buried/blind: 0 micro: 0)

Outer Annular Ring: 0.15 mm (6 mils)

- By design rules: 0.3 mm (12 mils)

Eurocircuits class: 4B
- Using min drill 0.5 mm for an OAR of 0.15 mm


# General stats

Components count: (SMD/THT)

- Top: 0/1 (THT)
- Bottom: 23/1 (SMD + THT)

Defined tracks:

- 0.3 mm (12 mils)
- 0.4 mm (16 mils)
- 0.5 mm (20 mils)
- 1.0 mm (39 mils)

Used tracks:

- 0.4 mm (16 mils) (47) defined: yes
- 0.5 mm (20 mils) (70) defined: yes

Defined vias:


Used vias:

- 0.8/0.4 mm (31/16 mils) (Count: 63, Aspect: 2.0 A) defined: no

Holes (excluding vias):

- 1.0 mm (39 mils) (3)
- 3.0 mm (118 mils) (1)

Oval holes:


Drill tools (including vias and computing adjusts and rounding):

- 0.5 mm (20 mils) (63)
- 1.1 mm (43 mils) (3)
- 3.1 mm (122 mils) (1)




