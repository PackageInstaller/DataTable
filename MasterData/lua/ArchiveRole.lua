--卡牌角色
local curSkinData = nil
local baseSkinData = nil
local panelNames = {"ArchiveRoleZLNew","ArchiveRoleZLNew", "ArchiveRoleTC", "ArchiveRoleJQ", "ArchiveRoleCG", "ArchiveRoleApparel"}
local lastIndex = 1
local lastSkinIdx = 1
local isAnim = false
local models = {}
local liveTog = nil
local isLive2D = false
local needToCheckMove = false
local timer = 0
local textMove = nil

function Awake()
	mTab = ComUtil.GetComInChildren(tab, "CTab")
	mTab:AddSelChangedCallBack(OnTabChanged)
	
	liveTog = ComUtil.GetCom(togLive, "Toggle")
	liveTog.isOn = isLive2D
	
	cardIconItem = RoleTool.AddRole(iconParent, PlayCB, EndCB)

	-- luaTextMove = LuaTextMove.New()
    -- luaTextMove:Init(txt_cv)
	textMove = ComUtil.GetCom(ImageName,"TextMove")
end

function OnInit()
	topLua = UIUtil:AddTop2("ArchiveRole", top, function()
		view:Close()
	end,nil, "")
end

function OnEnable()
	CSAPI.AddToggleCallBack(togLive, OnToggleChange)
	
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.CRole_PlayJQ, EPlayJQCB)
	eventMgr:AddListener(EventType.CRole_Update, SetLove)
end

function OnDestroy()
	CSAPI.RemoveToggleCallBack(togLive, OnToggleChange)
	eventMgr:ClearListener()
	RoleAudioPlayMgr:StopSound()
	ReleaseCSComRefs()
end

function OnToggleChange(_isOn)
	CSAPI.SetGOActive(togBg, not _isOn)
	CSAPI.SetGOActive(cm, _isOn)
	local color1 = _isOn and {15, 15, 25, 255} or {255, 255, 255, 125}
	local color2 = not _isOn and {15, 15, 25, 255} or {255, 255, 255, 125}
	isLive2D = _isOn
	CSAPI.SetTextColor(txt_live1, color1[1], color1[2], color1[3], color1[4])
	CSAPI.SetTextColor(txt_live2, color2[1], color2[2], color2[3], color2[4])
	SetRole(curSkinData:GetSkinID())
end

function Update()
    -- if (needToCheckMove and Time.time > timer) then
    --     luaTextMove:CheckMove(txt_cv)
    --     needToCheckMove = false
    -- end
end

function OnOpen()
	SetLeft()
	mTab.selIndex = 0

	if openSetting then
		--战斗中进来看需要隐藏home
		if(topLua and openSetting==1) then 
			topLua.SetHomeActive(false)
			CSAPI.SetGOActive(btnUIShow,false)
		elseif openSetting == 2 then --未获得卡牌隐藏
			CSAPI.SetGOActive(item2.gameObject, false)
			CSAPI.SetGOActive(item3.gameObject, false)
			CSAPI.SetGOActive(objLove,false)
		elseif openSetting == 3 then --关闭查看按钮
			CSAPI.SetGOActive(btnUIShow,false)
		end
	end
end

--页签
function OnTabChanged(index)
	if isAnim then
		return
	end
	if lastIndex ~= index then
		isAnim = true
		local yOffset = 339 - index * (54.6 + 80)
		local x, y = CSAPI.GetLocalPos(selLine)
		CSAPI.MoveTo(selLine, "UI_Local_Move", x,yOffset, 0, function()
			isAnim = false
		end, 0.1)
		lastIndex = index
	end
	SetRight(index)
end

--右节点
function SetRight(index)
	if(curIndex and index == 4) then
		mTab.selIndex = curIndex - 1
		-- Tips.ShowTips("未完善")
		return
	end
	if(curRight) then
		CSAPI.SetGOActive(curRight.gameObject, false)
	end
	AddPanel(index + 1)
end

--data> CRoleInfo
--所有皮肤
function SetLeft()
	local _models = data:GetAllSkins()
	for i, v in pairs(_models) do
		if v:CheckCanUseByMaxLV() then
			table.insert(models, v)
		end
	end
	table.sort(models, function(a, b)
		if(a:GetIndex() == b:GetIndex()) then
			return a:GetSkinID() < b:GetSkinID()
		else
			return a:GetIndex() < b:GetIndex()
		end
	end)
	
	curSkinData = models[1]
	baseSkinData = models[1]
	
	--角色
	SetRole(curSkinData:GetSkinID())
	--友好度
	SetLove()
	--皮肤预览
	-- SetSkin(models)
end

--角色
function SetRole(_moduleId)
	cfg = data:GetCfg()
	--name
	CSAPI.SetText(txtName, data:GetAlias())
	-- CSAPI.SetText(txtName2, data:GetEnName())
	--cv
	local cvName = cfg.sSounder_jp
	local language = SoundMgr:GetCVLanguage(data:GetSoundLanguageName())
	if language then
		if language == "cn" then
			cvName = cfg.sSounder_cn
		end
	end
	local cfStr = cvName
	-- needToCheckMove = false
	-- CSAPI.SetText(txt_cv, cfStr)
	-- needToCheckMove = true
	if not IsNil(textMove) then
		textMove:SetText(cfStr)
	end
	CSAPI.SetGOActive(left,not (cfStr == nil or cfStr == ""))
	--painter 
	local painterStr = LanguageMgr:GetByID(29056) .. ":" .. cfg.sPainter
	CSAPI.SetText(txt_painter, painterStr)
	--icon
	SetIcon(_moduleId)

	local cfgMEnum = Cfgs.CfgMonsterEnum:GetByID(tonumber(cfg.tType))
	CSAPI.SetText(txtType, cfgMEnum.sName or "")
	local cfgRace = Cfgs.CfgRaceEnum:GetByID(tonumber(cfg.tRace))
	CSAPI.SetText(txtRace, cfgRace.sName or "")
	local cfgBody = Cfgs.CfgBodyEnum:GetByID(tonumber(cfg.tBody))
	CSAPI.SetText(txtBody, cfgBody.sName or "")
end

function SetIcon(_moduleId)
	if RoleSkinMgr:CheckLive2DExist(_moduleId)  then
		CSAPI.SetGOActive(togLive, true)
	else
		CSAPI.SetGOActive(togLive, false)
		isLive2D = false
	end
	cardIconItem.Refresh(_moduleId, LoadImgType.Archive, nil, isLive2D)
end

function SetLove()
	-- CSAPI.SetGOActive(objLove, false)
	CSAPI.SetGOActive(objLove, data:GetCfg().bHadLv)
	if(data:GetCfg().bHadLv) then
		CSAPI.SetText(txtLove, data:GetLv() .. "")
	end
end

function SetSkin(_datas)
	for i = 1, 3 do
		CSAPI.SetGOActive(this["skin" .. i].gameObject, false)
	end
	for i, v in ipairs(_datas) do	
		CSAPI.SetGOActive(this["skin" .. i].gameObject, true)
		ResUtil.Card:Load(this["icon" .. i].gameObject, v:GetCfg().List_head)
		if i == 1 then
			CSAPI.SetScale(this["skin" .. i].gameObject, 1, 1, 1)
			lastSkinGo = this["skin" .. i].gameObject
		else
			CSAPI.SetScale(this["skin" .. i].gameObject, 0.8, 0.8, 1)
		end
	end
	local width = #_datas > 1 and 995 or 1209
	CSAPI.SetRTSize(skinLine, width, 6)
	
	--GetSmallImg
	-- if #cDatas == 1 then
	-- 	CSAPI.SetGOActive(skin1,false)
	-- 	CSAPI.SetGOActive(skin2,true)
	-- 	CSAPI.SetGOActive(skin3,false)
	-- else
	-- end
end

function AddPanel(i)
	if i == 3 and curIndex ~= i then
		AnimStart()
		FuncUtil:Call(AnimEnd,nil,1000)
	end
	curIndex = i
	panels = panels or {}
	local panel = panels[panelNames[i]]
	if(panel) then
		CSAPI.SetGOActive(panel.gameObject, true)
	else
		local go = ResUtil:CreateUIGO("Archive3/" .. panelNames[i], panelParent.transform)
		panel = ComUtil.GetLuaTable(go)
		panels[panelNames[i]] = panel
	end
	-- local elseData = curSkinData
	local elseData = baseSkinData
	if(panelNames[i] == "ArchiveRoleApparel") then
		panel.SetRoleParent(cardIconItem)
	elseif(panelNames[i] == "ArchiveRoleTC") then
		panel.SetCardIconItem(cardIconItem)
	elseif(panelNames[i] == "ArchiveRoleZLNew") then
		elseData = i
	end
	panel.Refresh(data, elseData)
	curRight = panel
	
	--判断是否有数据
	local curDatas = {}
	if(i == 3) then
		-- local voiceInfo = CRoleMgr:GetScriptCfg(data:GetID(), curSkinData:GetSkinID())
		-- curDatas = voiceInfo and voiceInfo:GetArr() or {}
		-- curDatas = CRoleMgr:GetScriptCfgs(data:GetID(), curSkinData:GetSkinID())
		curDatas = CRoleMgr:GetRoleScriptCfgs(data:GetID(), true)
	elseif(i == 4) then
		curDatas = CRoleMgr:GetStory(data:GetID(), curSkinData:GetSkinID())
	elseif(i == 5) then
		curDatas = CRoleMgr:GetCG(data:GetID()) or {}
	else
		curDatas = {1}
	end
	CSAPI.SetGOActive(empty, #curDatas <= 0)
end

--皮肤剧情奖励
function EPlayJQCB(proto)
	-- local id, index = proto.id, proto.index
	-- if(id and index) then
	-- 	local cfgs = Cfgs.CfgCardRoleStory:GetByID(id).infos
	-- 	local cfg = cfgs[index]
	-- 	local rewards = cfg.rewards
	-- 	if(rewards) then
	-- 		local datas = {}
	-- 		for i, v in ipairs(rewards) do
	-- 			local data = {id = v[1], num = v[2], type = v[3]}
	-- 			table.insert(datas, data)
	-- 		end
	-- 		if(#datas > 0) then
	-- 			UIUtil:OpenReward({datas})
	-- 		end
	-- 	end
	-- end
	if(curRight) then
		curRight.Refresh(data, curSkinData)
	end
end

function OnClickUIShow()
	local cardData = RoleMgr:GetMaxFakeData(data:GetID())
	CSAPI.OpenView("RoleInfo", cardData)
	-- SetAmplification(true)
end

--设置放大
function SetAmplification(_show)
	if(showIng and showIng == _show) then
		return
	end
	showIng = _show
	if(_show) then
		local imgScale = cardIconItem.GetCfgScale()		
		cardIconItem.SetClickActive(false)
		CSAPI.SetGOActive(showBg, true)
		CSAPI.SetParent(iconParent, showBg)
		if(not uiHandle) then
			uiHandle = ComUtil.GetCom(showBg, "UIHandle")
			uiHandle.isMoveLimit = false 
		end
		uiHandle:InitParm(1, 1, g_CardLookScale[1] / imgScale, g_CardLookScale[2] / imgScale)  --对应的是父类不是role
		uiHandle:Init(iconParent, function()
			SetAmplification(false)
		end)
	else
		uiHandle:Init(nil)			
		CSAPI.SetAnchor(iconParent, 0, 0)
		CSAPI.SetParent(iconParent, roleMask)
		CSAPI.SetGOActive(showBg, false)
		cardIconItem.SetClickActive(true)
	end
end

--开始播放
function PlayCB(curCfg)
	if(curIndex == 3 and curRight and curRight.PlayCB) then
		curRight.PlayCB(curCfg)
	end
end

--播放后
function EndCB()
	if(curIndex == 3 and curRight and curRight.EndCB) then
		curRight.EndCB()
	end
end

function AnimStart()
	CSAPI.SetGOActive(clickMask,true)
end

function AnimEnd()
	CSAPI.SetGOActive(clickMask,false)
end

function OnClickSkin(go)
	if lastSkinGo then
		if lastSkinGo == go then return end			
		CSAPI.SetScale(lastSkinGo, 0.8, 0.8, 1)
	end
	CSAPI.SetScale(go, 1, 1, 1)
	lastSkinGo = go
	for i = 1, 3 do
		if go.name == "skin" .. i then
			local _data = models[i]
			curSkinData = _data
			liveTog.isOn = false
			SetRole(_data:GetSkinID())
			AddPanel(curIndex)
		end
	end
end 
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
node=nil;
roleMask=nil;
iconParent=nil;
skinLine=nil;
skinTab=nil;
skin1=nil;
icon1=nil;
skin2=nil;
icon2=nil;
skin3=nil;
icon3=nil;
right=nil;
txtName=nil;
txtName2=nil;
selLine=nil;
tab=nil;
objLove=nil;
txtLove=nil;
left=nil;
txt_cv=nil;
txt_painter=nil;
togLive=nil;
togBg=nil;
cm=nil;
txt_live1=nil;
txt_live2=nil;
panelParent=nil;
empty=nil;
top=nil;
showBg=nil;
view=nil;
end
----#End#----