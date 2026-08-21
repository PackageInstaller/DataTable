if DialogShowMode == nil then
    DialogShowMode =
    {
        Show = 1,
        Gray = 2,
        Hide = 3
    }
end

if SpeedMode == nil then
    SpeedMode =
    {
        Default = 1,
        AutoOne = 2,
        AutoTwo = 3,
    }
end

if ContentType == nil then
    ContentType =
    {
        Title = 1,
        Choose = 2,
        Dialog = 3
    }
end

--- y轴位置 为 Common 的基础上进行调整, 并不是填写一个绝对值
if CharacterHeight == nil then
    CharacterHeight = {}
    CharacterHeight["Common"] = 420
    CharacterHeight["1002_LiShiMin_Stage1"] = 40
    CharacterHeight["1003_LiuXie_Stage1"] = -140
    CharacterHeight["1003_LiuXie_Stage2"] = -140
    
    CharacterHeight["1004_GouJian_Stage1"] = 50
    CharacterHeight["1004_GouJian_Stage2"] = 50
    CharacterHeight["1004_GouJian_Stage2_Black"] = 50
    
    CharacterHeight["1006_QianLong_Stage1"] = -40
    CharacterHeight["1006_QianLong_Stage2"] = -40
    CharacterHeight["1006_QianLong_Stage2_Black"] = -40
    
    CharacterHeight["1007_LuYiShiSi_Stage1"] = -30
    
    CharacterHeight["1008_NaPoLun_Stage1"] = 20
    
    CharacterHeight["1012_WangMang_Stage1"] = -120
    CharacterHeight["1012_WangMang_Stage2"] = -120
    CharacterHeight["1012_WangMang_Stage2_Black"] = -120
    
    CharacterHeight["1013_ZhaoGou_Stage1"] = -140
    CharacterHeight["1013_ZhaoGou_Stage2"] = -140

    CharacterHeight["1015_LvBu_Stage1_Eye_Whole"] = 180
    CharacterHeight["1015_LvBu_Stage1_NoEye_Whole"] = 180
    
    CharacterHeight["1018_DaYu_Stage1"] = -20
    CharacterHeight["1018_DaYu_Stage2"] = -20

    CharacterHeight["1025_YuZaoQian_Stage2"] = -140
    
    CharacterHeight["1026_LuoYiGe_JueXing"] = -50
    CharacterHeight["1026_LuoYiGe_Stage1"] = -50
    
    CharacterHeight["1027_ZhaEr_JueXing"] = -50
    CharacterHeight["1027_ZhaEr_Stage1"] = -50
    
    CharacterHeight["1028_HaSiTa"] = -50
    CharacterHeight["1028_HaSiTa_Stage1"] = -50
    CharacterHeight["1028_HaSiTa_Stage2"] = -50
    
    CharacterHeight["1029_NaiYa_Stage2"] = 50

    CharacterHeight["1030_ShenGongBao_Stage2_Black"] = -60
    CharacterHeight["1030_ShenGongBao_Stage2"] = -60
    CharacterHeight["1030_ShenGongBao_Stage2_Black_Whole"] = -60
    CharacterHeight["1030_ShenGongBao_Stage2_Whole"] = -60
    
    CharacterHeight["1101_XuKongXingZhe"] = 80
    
    CharacterHeight["1102_BuSiLingZhu"] = 120

    CharacterHeight["1112_KeZhanNvEr"] = -120
    CharacterHeight["1106_LongXingJieShiBing1"] = 50
    CharacterHeight["1107_LongXingJieShiBing2"] = 60
    CharacterHeight["1108_LongXingJieShiBing3"] = 50
    CharacterHeight["1121_LongZhiJinWei"] = 50
    CharacterHeight["1121_LongZhiJinWei_Black"] = 50

    CharacterHeight["1117_XiuGeSi"] = 120
    CharacterHeight["1117_XiuGeSi_Black"] = 120
    CharacterHeight["1118_HuoLong"] = 120
    CharacterHeight["1120_MoLang"] = 100

    CharacterHeight["1122_AnShaZhe"] = 30
    CharacterHeight["1123_KuLouBing"] = -120

    CharacterHeight["1125_XingTian"] = 110
    CharacterHeight["1128_CangLong"] = 120
    CharacterHeight["1145_JinJiangShi"] = 70
end

--- x轴 为 Common 的基础上进行调整, 并不是填写一个绝对值
if CharacterWidth == nil then
    CharacterWidth = {}
    CharacterWidth["Common"] = 0
    CharacterWidth["1118_HuoLong"] = -200
end

-- scale 为绝对值
if CharacterScale == nil then
    CharacterScale = {}
    CharacterScale["Common"] = 1
    CharacterScale["1000_XianZhi"] = 1.1
    CharacterScale["1003_LiuXie_Stage1"] = 0.9
    CharacterScale["1003_LiuXie_Stage2"] = 0.9
    CharacterScale["1025_YuZaoQian_Stage2"] = 0.9
    CharacterScale["1112_KeZhanNvEr"] = 0.85
    CharacterScale["1030_ShenGongBao_Stage2_Black"] = 0.7
    CharacterScale["1030_ShenGongBao_Stage2"] = 0.7
    CharacterScale["1030_ShenGongBao_Stage2_Black_Whole"] = 0.7
    CharacterScale["1030_ShenGongBao_Stage2_Whole"] = 0.7
    CharacterScale["1122_AnShaZhe"] = 1.1
end
