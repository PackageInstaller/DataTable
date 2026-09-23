-- 资料
local curIndex = 1
local lastIndex = 0
local needToCheckMove = false
local timer = 0

function Awake()
    LanguageMgr:SetText(txtPG, 29071)
    -- CSAPI.SetText(txtPG, "战力评估")

    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtB5)
end

function Update()
    if (needToCheckMove and Time.time > timer) then
        luaTextMove:CheckMove(txtB5)
        needToCheckMove = false
    end
end

-- 卡牌角色资料
function Refresh(_data, _elseData)
    data = _data
    curIndex = _elseData or 1
    cfg = data:GetCfg()
    SetSV()

    if (data and cfg) then
        -- InitData()
        -- SetInfo()
        SetA()
        SetB()
        SetC()
        SetD()
        SetE()
    end

end

function SetSV()
    CSAPI.SetGOActive(sv1, curIndex == 1)
    CSAPI.SetGOActive(sv2, curIndex == 2)

    if lastIndex ~= curIndex then
        lastIndex = curIndex
        CSAPI.SetAnchor(curIndex == 1 and content1 or content2, 0, 0)
    end
end

function SetA()
    -- 所属
    local _teamCfg = Cfgs.CfgBelonging:GetByID(cfg.sBelonging)
    local str1 = LanguageMgr:GetByID(29065) .. StringUtil:SetByColor(_teamCfg.sName, "929296")
    CSAPI.SetText(txtA1, str1)
    -- 出身
    local TerritoryCfg = Cfgs.CfgTerritoryEnum:GetByID(cfg.sBirthPlace)
    local territoryCfgName = TerritoryCfg and TerritoryCfg.sName or ""
    local str2 = LanguageMgr:GetByID(29066) .. StringUtil:SetByColor(territoryCfgName, "929296")
    CSAPI.SetText(txtA2, str2)
end

function SetB()
    -- 性别
    local sexCfg = Cfgs.CfgGenDerEnum:GetByID(cfg.sSex)
    local sexName = sexCfg and sexCfg.sName or ""
    CSAPI.SetText(txtB1, sexName)
    -- 生日/年龄
    CSAPI.SetText(txtB2, cfg.sBirthDay)
    -- 血型
    CSAPI.SetText(txtB3, cfg.sBloodType)
    -- 身高
    -- CSAPI.SetText(txtB4, cfg.sHeight)
    -- 喜欢
    if curIndex == 1 then
        needToCheckMove = false
        CSAPI.SetText(txtB5, cfg.sHoppy)
        timer = Time.time + 0.1
        needToCheckMove = true
    end
    -- 邂逅
    local timer = data:GetCreateTime()
    if timer > 0 then
        timer = TimeUtil:GetTimeHMS(timer, "%Y/%m/%d")
        CSAPI.SetText(txtB6, timer)
    else
        CSAPI.SetText(txtB6, "？？？？")
    end
end

function SetC()
    -- 身体素质
    CSAPI.SetText(txtC1_1, cfg.sPhysicalAbi)
    CSAPI.SetText(txtC1, cfg.sPhysical)
    -- 战斗技巧
    CSAPI.SetText(txtC2_1, cfg.sTechniqueAbi)
    CSAPI.SetText(txtC2, cfg.sTechnique)
    -- 战斗意志
    CSAPI.SetText(txtC3_1, cfg.sMoraleAbi)
    CSAPI.SetText(txtC3, cfg.sMorale)
    -- 队伍协调
    CSAPI.SetText(txtC4_1, cfg.sHarmonyAbi)
    CSAPI.SetText(txtC4, cfg.sHarmony)
    -- 总评
    CSAPI.SetText(txtC5_1, cfg.sEstimateAbi)
    CSAPI.SetText(txtC5, cfg.sEstimate)
end

function SetD()
    -- 档案
    CSAPI.SetGOActive(txtD1, cfg.sRecord1 ~= nil)
    local str1 = cfg.sRecord1 or ""
    str1 = str1:gsub("%%s", PlayerClient:GetName())
    str1 = StringUtil:IndentFirstLine(str1, true)
    str1 = StringUtil:ReplaceSpace(str1)
    CSAPI.SetText(txtD1, str1)
    CSAPI.SetGOActive(txtD2, cfg.sRecord2 ~= nil)
    local str2 = cfg.sRecord2 or ""
    str2 = str2:gsub("%%s", PlayerClient:GetName())
    str2 = StringUtil:IndentFirstLine(str2, true)
    str2 = StringUtil:ReplaceSpace(str2)
    CSAPI.SetText(txtD2, str2)
end

function SetE()
    if cfg.bHadLv then
        CSAPI.SetGOActive(txtE1, data:GetLv() >= cfg.sInterview1Lv)
        CSAPI.SetGOActive(txtE2, data:GetLv() >= cfg.sInterview2Lv)
        CSAPI.SetGOActive(txtE3, data:GetLv() >= cfg.sInterview3Lv)
        CSAPI.SetText(txtLock1,
            data:GetLv() >= cfg.sInterview1Lv and "" or LanguageMgr:GetByID(29055, cfg.sInterview1Lv))
        CSAPI.SetText(txtLock2,
            data:GetLv() >= cfg.sInterview2Lv and "" or LanguageMgr:GetByID(29055, cfg.sInterview2Lv))
        CSAPI.SetText(txtLock3,
            data:GetLv() >= cfg.sInterview3Lv and "" or LanguageMgr:GetByID(29055, cfg.sInterview3Lv))
    else
        CSAPI.SetGOActive(e1Obj, false)
        CSAPI.SetGOActive(e2Obj, false)
        CSAPI.SetGOActive(e3Obj, false)
    end
    -- 访谈1
    local str1 = cfg.sInterview1 or ""
    str1 = str1:gsub("%%s", PlayerClient:GetName())
    str1 = StringUtil:IndentFirstLine(str1, true)
    str1 = StringUtil:ReplaceSpace(str1)
    CSAPI.SetText(txtE1, str1)
    -- 访谈2
    local str2 = cfg.sInterview2 or ""
    str2 = str2:gsub("%%s", PlayerClient:GetName())
    str2 = StringUtil:IndentFirstLine(str2, true)
    str2 = StringUtil:ReplaceSpace(str2)
    CSAPI.SetText(txtE2, str2)
    -- 访谈3
    local str3 = cfg.sInterview3 or ""
    str3 = str3:gsub("%%s", PlayerClient:GetName())
    str3 = StringUtil:IndentFirstLine(str3, true)
    str3 = StringUtil:ReplaceSpace(str3)
    CSAPI.SetText(txtE3, str3)
end

function OnClickZL()
    BtnFade()
    curIndex = curIndex == 1 and 2 or 1
    CSAPI.SetAnchor(content1, 0, 0)
    CSAPI.SetAnchor(content2, 0, 0)
    SetSV()
end

function BtnFade()
    if not btnFade then
        btnFade = ComUtil.GetCom(btnZL, "ActionFade")
    end
    btnFade.delayValue = 1
    btnFade:Play(1, 0, 200, 0, function()
        btnFade.delayValue = 0
        btnFade:Play(0, 1, 150)
    end)

end

--[[function InitData()
	datas = {}
	local b = true
	local curLv = data:GetLv() or 1
	
	--名字
	AddData(cfg.sName)
	--所属阵营
	local _teamCfg = Cfgs.CfgTeamEnum:GetByID(cfg.sTeam)
	AddData(_teamCfg.sName)
	--邂逅
	local timer = data:GetCreateTime()
	timer = TimeUtil:GetTimeHMS(timer, "%Y/%m/%d")
	AddData(timer)	
	--性别
	local sexCfg = Cfgs.CfgGenDerEnum:GetByID(cfg.sSex)
	local sexName = sexCfg and sexCfg.sName or ""
	AddData(sexName)	
	--血型
	--b = cfg.nBloodTypeLv < data:GetLv()
	AddData(cfg.sBloodType)	
	--出生地
	--b = cfg.nBirthPlaceLv < curLv
	local TerritoryCfg = Cfgs.CfgTerritoryEnum:GetByID(cfg.sBirthPlace)
	local territoryCfgName = TerritoryCfg and TerritoryCfg.sName or ""
	AddData(territoryCfgName)	
	--生日/年龄
	--local b = cfg.nBirthDayLv < curLv
	AddData(cfg.sBirthDay .. "·" .. cfg.sAge)	
	--年龄
	--b = cfg.nAgeLv < curLv
	--AddData(cfg.sAge)	
	--三围
	--b = cfg.nStatureLv < data:GetLv()
	AddData(cfg.sStature)
	--身高
	--b = cfg.nHeightLv < data:GetLv()
	AddData(cfg.sHeight .. "/" .. cfg.sWeight)
	--体重
	--b = cfg.nWeight < data:GetLv()
	--AddData(cfg.sWeight)
	--兴趣
	--b = cfg.nInterestLv < data:GetLv()
	AddData(cfg.sInterest)
	--喜欢
	--b = cfg.nHoppyLv < data:GetLv()
	AddData(cfg.sHoppy)	
	--讨厌
	--b = cfg.nHateLv < data:GetLv()
	AddData(cfg.sHate)	
	--故事
	--b = cfg.nStoryLv < data:GetLv()
	AddData("")	
	
	AddData(cfg.sStory)
	--代号
	--AddData(StringConstant.cRole_5[2], StringUtil:SetColor(cfg.sAliasName, "yellow"))
end

function AddData(_str1)
	table.insert(datas, _str1)
end

function SetInfo()
	local str = ""
	for i, v in ipairs(datas) do
		if(i <= #StringConstant.cRole_5) then
			str = StringConstant.cRole_5[i]
			ZYUtil:SetText(this["txt" .. i], str .. "：" .. v)
		else
			ZYUtil:SetText(this["txt" .. i], v)
		end
	end
end
]]

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    sv1 = nil;
    content1 = nil;
    txt_a1 = nil;
    txt_a2 = nil;
    txtA1 = nil;
    txtA2 = nil;
    txt_b1 = nil;
    txt_b2 = nil;
    txt_b3 = nil;
    txt_b4 = nil;
    txt_b5 = nil;
    txt_b6 = nil;
    txtB1 = nil;
    txtB2 = nil;
    txtB3 = nil;
    txtB4 = nil;
    txtB5 = nil;
    txtB6 = nil;
    txtPG = nil;
    txt_c1 = nil;
    txt = nil;
    txtC1_1 = nil;
    txtC1 = nil;
    txt_c2 = nil;
    txt = nil;
    txtC2_1 = nil;
    txtC2 = nil;
    txt_c3 = nil;
    txt = nil;
    txtC3_1 = nil;
    txtC3 = nil;
    txt_c4 = nil;
    txt = nil;
    txtC4_1 = nil;
    txtC4 = nil;
    txt_c5 = nil;
    txt = nil;
    txtC5_1 = nil;
    txtC5 = nil;
    sv2 = nil;
    content2 = nil;
    txt_d1 = nil;
    txt = nil;
    txtD1 = nil;
    txt_d2 = nil;
    txt = nil;
    txtD2 = nil;
    e1Obj = nil;
    txt_e1 = nil;
    txt = nil;
    txtLock1 = nil;
    txtE1 = nil;
    e2Obj = nil;
    txt_e2 = nil;
    txt = nil;
    txtLock2 = nil;
    txtE2 = nil;
    e3Obj = nil;
    txt_e3 = nil;
    txt = nil;
    txtLock3 = nil;
    txtE3 = nil;
    btnZL = nil;
    txtZL = nil;
    view = nil;
end
----#End#----
