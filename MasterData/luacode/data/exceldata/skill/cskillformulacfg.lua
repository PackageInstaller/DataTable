local cskillformulacfg = {}
cskillformulacfg.Data = {
  [1] = {
    id = 1,
    FormulaName = "phydmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1*attacka+extraphysicaldmga-physicalblockb)*3000/math.max((3000+defendb-physicaldefbreaka) ,1500)*math.max((1+physicalbonusa+dmgskilladda-physicalreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticattacka)"
  },
  [2] = {
    id = 2,
    FormulaName = "magdmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1*attacka+extramagicdmga-magicblockb)*3000/math.max((3000+magicdefb-magicdefbreaka) ,1500) *math.max((1+magicbonusa+dmgskilladda-magicreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticattacka)"
  },
  [3] = {
    id = 3,
    FormulaName = "heal",
    attr = {"attr1"},
    Formula = "(healingpowera+attr1*attacka)*math.max((1+magicbonusa+healskilladda+curativeaddb),0)",
    BaseDamageFormula = "attr1*attacka*(1+bonusa+healskilladda+curativeaddb)"
  },
  [4] = {
    id = 4,
    FormulaName = "atkphydmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1*attacka+extraphysicaldmga-physicalblockb)*3000/math.max((3000+defendb-physicaldefbreaka) ,1500) *math.max((1+physicalbonusa-physicalreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticattacka)"
  },
  [5] = {
    id = 5,
    FormulaName = "atkmagdmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1*attacka+extramagicdmga-magicblockb)*3000//math.max((3000+magicdefb-magicdefbreaka) ,1500) *math.max((1+magicbonusa-magicreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticattacka)"
  },
  [6] = {
    id = 6,
    FormulaName = "atkheal",
    attr = {"attr1"},
    Formula = "(healingpowera+attr1*attacka)*math.max((1+magicbonusa+curativeaddb),0)",
    BaseDamageFormula = "attr1*attacka*(1+bonusa+curativeaddb)"
  },
  [7] = {
    id = 7,
    FormulaName = "attackbonus",
    attr = {"attr1"},
    Formula = "attr1*staticattacka",
    BaseDamageFormula = "attr1*staticattacka"
  },
  [8] = {
    id = 8,
    FormulaName = "hpheal",
    attr = {"attr1"},
    Formula = "(healingpowera+attr1*maxhpa)*math.max((1+magicbonusa+healskilladda+curativeaddb),0)",
    BaseDamageFormula = "attr1*maxhpa*(1+magicbonusa+healskilladda+curativeaddb)"
  },
  [9] = {
    id = 9,
    FormulaName = "staticphydmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1+extraphysicaldmga-physicalblockb)*3000/math.max((3000+defendb-physicaldefbreaka) ,1500)*math.max((1+physicalbonusa+dmgskilladda-physicalreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticattacka)"
  },
  [10] = {
    id = 10,
    FormulaName = "staticmagdmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1+extramagicdmga-magicblockb)*3000/math.max((3000+magicdefb-magicdefbreaka) ,1500) *math.max((1+magicbonusa+dmgskilladda-magicreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticattacka)"
  },
  [11] = {
    id = 11,
    FormulaName = "defheal",
    attr = {"attr1"},
    Formula = "(healingpowera+attr1*defenda)*math.max((1+magicbonusa+healskilladda+curativeaddb),0)",
    BaseDamageFormula = "attr1*maxhpa*(1+magicbonusa+healskilladda+curativeaddb)"
  },
  [12] = {
    id = 12,
    FormulaName = "magdefheal",
    attr = {"attr1"},
    Formula = "(healingpowera+attr1*magdefa)*math.max((1+magicbonusa+healskilladda+curativeaddb),0)",
    BaseDamageFormula = "attr1*maxhpa*(1+magicbonusa+healskilladda+curativeaddb)"
  },
  [13] = {
    id = 13,
    FormulaName = "phyhpdmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1*maxhpa+extraphysicaldmga-physicalblockb)*3000/math.max((3000+defendb-physicaldefbreaka) ,1500)*math.max((1+physicalbonusa+dmgskilladda-physicalreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticmaxhpa)"
  },
  [14] = {
    id = 14,
    FormulaName = "maghpdmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1*maxhpa+extramagicdmga-magicblockb)*3000/math.max((3000+magicdefb-magicdefbreaka) ,1500) *math.max((1+magicbonusa+dmgskilladda-magicreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticmaxhpa)"
  },
  [15] = {
    id = 15,
    FormulaName = "hpdmg",
    attr = {"attr1"},
    Formula = "-math.max(1,attr1*staticmaxhpa)",
    BaseDamageFormula = "-math.max(1,attr1*staticmaxhpa)"
  },
  [16] = {
    id = 16,
    FormulaName = "snphydmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1*attacka+extraphysicaldmga-physicalblockb)*3000/math.max((3000+defendb-fixedpoint(\"0.2\")*staticdefendb-physicaldefbreaka) ,1500)*math.max((1+physicalbonusa+dmgskilladda-physicalreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticattacka)"
  },
  [17] = {
    id = 17,
    FormulaName = "xnphydmg",
    attr = {"attr1", "attr2"},
    Formula = "-math.max(1,(attr1*attacka+extraphysicaldmga-physicalblockb)*3000/math.max((3000+defendb-attr2*attacka-physicaldefbreaka) ,1500)*math.max((1+physicalbonusa+dmgskilladda-physicalreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticattacka)"
  },
  [18] = {
    id = 18,
    FormulaName = "aksphydmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1*attacka+extraphysicaldmga-physicalblockb)*3000/math.max((3000+defendb-staticdefendb-physicaldefbreaka) ,1500)*math.max((1+physicalbonusa+dmgskilladda-physicalreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticattacka)"
  },
  [19] = {
    id = 19,
    FormulaName = "endureheal",
    attr = {"attr1"},
    Formula = "(healingpowera+attr1*totaldmgb)*math.max((1+magicbonusa+healskilladda+curativeaddb),0)",
    BaseDamageFormula = "attr1*totaldmgb*(1+magicbonusa+healskilladda+curativeaddb)"
  },
  [20] = {
    id = 20,
    FormulaName = "sjphyhpdmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1*maxhpa+extraphysicaldmga-physicalblockb)*3000/math.max((3000+defendb-physicaldefbreaka) ,1500)*math.max((1+physicalbonusa-physicalreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticmaxhpa)"
  },
  [21] = {
    id = 21,
    FormulaName = "linkmagdmg",
    attr = {"attr1"},
    Formula = "-math.max(1,(attr1*attacka+extramagicdmga-magicblockb)*3000/math.max((3000+magicdefb-magicdefbreaka) ,1500) *math.max((1+magicbonusa-magicreduceb),fixedpoint(\"0.01\")) )*math.max((1-damagereduceb),fixedpoint(\"0.01\"))",
    BaseDamageFormula = "-math.max(1,attr1*staticattacka)"
  },
  [22] = {
    id = 22,
    FormulaName = "staticdmg",
    attr = {"attr1"},
    Formula = "-math.max(1,attr1)",
    BaseDamageFormula = "-math.max(1,attr1*staticmaxhpa)"
  }
}
cskillformulacfg.AllIds = {
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22
}
return cskillformulacfg
