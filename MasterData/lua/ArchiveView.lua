
local newName = {"roleNew", "", "goodsNew", "memoryNew", "equipNew", "enemyNew","boardNew","musicNew","asmrNew","skinNew","biteNew","storyCollectionNew"}
local top=nil;
local records = {}
function Awake()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.RedPoint_Refresh,OnRedRefresh)
end

function OnRedRefresh()
	local isRed = ASMRMgr:IsRed()
	CSAPI.SetGOActive(asmrNew, isRed)
	ArchiveMgr:SetIsNew(ArchiveType.Asmr, isRed)
	isRed = MissionMgr:CheckRed({eTaskType.StoryCollection})
	CSAPI.SetGOActive(storyCollectionNew, isRed)
	ArchiveMgr:SetIsNew(ArchiveType.StoryCollection, isRed)
end

function OnDestroy()
	eventMgr:ClearListener()
end

function OnInit()
	top=UIUtil:AddTop2("ArchiveView", gameObject, function()
		view:Close()
	end, nil, "")
end

function OnOpen()
	CSAPI.PlayUISound("ui_generic_click_return")	
	InitPanel()
end

function InitPanel()
	InitRolePanel()
	InitEnemyPanel()
	InitMemoryPanel()
	
	InitNew()
	-- Log(records)
	SetButtonOpen()
end

function SetButtonOpen()
	local cfgs = Cfgs.CfgArchive:GetAll()
	if cfgs and #cfgs > 0 then
		local sTime,eTime = 0,0
		for k, cfg in ipairs(cfgs) do
			if cfg.sTime and cfg.eTime then
				sTime = TimeUtil:GetTimeStampBySplit(cfg.sTime)
				eTime = TimeUtil:GetTimeStampBySplit(cfg.eTime)
				if TimeUtil:GetTime() < sTime or TimeUtil:GetTime() >= eTime then
					CSAPI.SetGOActive(this["btn" .. ArchiveNameType[cfg.id]].gameObject,false)
				end
			end
		end
	end
end

--角色
function InitRolePanel()
	local count, max = ArchiveMgr:GetRoleCount()
	CSAPI.SetText(txtRoleNum1, count .. "")
	CSAPI.SetText(txtRoleNum2, "/" .. max)
	local percent = math.floor(count / max * 100)
	CSAPI.SetText(txtRoleNum3, percent .. "%")
	CSAPI.SetRTSize(roleLine, 27 + 271 * percent / 100, 36)
	records["role"] = percent
end

function OnRoleDown()
	CSAPI.SetUIScaleTo(btnRole, nil, 1.06, 1.06, 1, nil, 0.14)
	if not roleT then
		roleT = ComUtil.GetCom(roleFadeT, "ActionFadeT")
	end
	roleT:Play()
end

function OnRoleUp()
	CSAPI.SetUIScaleTo(btnRole, nil, 1, 1, 1, function()
		OnClickRole()
	end, 0.15)
end

function OnClickRole()
	local isNew = ArchiveMgr:GetIsNew(ArchiveType.Role)
	if isNew then
		CSAPI.SetGOActive(roleNew, false)
		SetIsNew(ArchiveType.Role)
	end
	if not CSAPI.IsViewOpen("ArchiveRoleListView") then
		CSAPI.OpenView("ArchiveRoleListView", ArchiveType.Role)
	end
end

--敌兵
function InitEnemyPanel()
	local count, max = ArchiveMgr:GetEnemyCount()
	CSAPI.SetText(txtEnemyNum1, count .. "")
	CSAPI.SetText(txtEnemyNum2, "/" .. max)
	local percent = math.floor(count / max * 100)
	CSAPI.SetText(txtEnemyNum3, percent .. "%")
	CSAPI.SetRTSize(enemyLine, 27 + 369 * percent / 100, 36)
	records["enemy"] = percent
end

function OnEnemyDown()
	CSAPI.SetUIScaleTo(btnEnemy, nil, 1.06, 1.06, 1, nil, 0.14)
	if not enemyT then
		enemyT = ComUtil.GetCom(enemyFadeT, "ActionFadeT")
	end
	enemyT:Play()
end

function OnEnemyUp()
	CSAPI.SetUIScaleTo(btnEnemy, nil, 1, 1, 1, function()
		OnClickEnemy()
	end, 0.15)
end

function OnClickEnemy()
	local isNew = ArchiveMgr:GetIsNew(ArchiveType.Enemy)
	if isNew then
		CSAPI.SetGOActive(enemyNew, false)
		SetIsNew(ArchiveType.Enemy)
	end
	if not CSAPI.IsViewOpen("ArchiveRoleListView") then
		CSAPI.OpenView("ArchiveRoleListView", ArchiveType.Enemy)
	end
end

--装备
function OnClickEquip()	
	--Tips.ShowTips(StringConstant.tips1)
	-- Tips.ShowTips("敬请期待")
end


--回忆
function InitMemoryPanel()
	local count, max = ArchiveMgr:GetMemoriesCount()
	CSAPI.SetText(txtMemoryNum1, count .. "")
	CSAPI.SetText(txtMemoryNum2, "/" .. max)
	local percent = math.floor(count / max * 100)
	CSAPI.SetText(txtMemoryNum3, percent .. "%")
	CSAPI.SetRTSize(memoryLine, 27 + 443 * percent / 100, 36)
	records["memory"] = percent
end

function OnMemoryDown()
	CSAPI.SetUIScaleTo(btnMemory, nil, 1.06, 1.06, 1, nil, 0.14)
	if not memoryT then
		memoryT = ComUtil.GetCom(memoryFadeT, "ActionFadeT")
	end
	memoryT:Play()
end

function OnMemoryUp()
	CSAPI.SetUIScaleTo(btnMemory, nil, 1, 1, 1, function()
		OnClickMemory()
	end, 0.15)
end

function OnClickMemory()
	local isNew = ArchiveMgr:GetIsNew(ArchiveType.Story)
	if isNew then
		CSAPI.SetGOActive(memoryNew, false)
		SetIsNew(ArchiveType.Story)
	end
	if not CSAPI.IsViewOpen("ArchiveStoryView") then
		CSAPI.OpenView("ArchiveStoryView")
	end
	--Tips.ShowTips("敬请期待")
end

--教程
function OnCourseDown()
	CSAPI.SetUIScaleTo(btnCourse, nil, 1.06, 1.06, 1, nil, 0.14)
	if not courseT then
		courseT = ComUtil.GetCom(courseFadeT, "ActionFadeT")
	end
	courseT:Play()
end

function OnCourseUp()
	CSAPI.SetUIScaleTo(btnCourse, nil, 1, 1, 1, function()
		OnClickCourse()
	end, 0.15)
end

function OnClickCourse()
	if not CSAPI.IsViewOpen("ArchiveCourseView") then
		CSAPI.OpenView("ArchiveCourseView")
	end
end

--物品
function OnGoodsDown()
	CSAPI.SetUIScaleTo(btnGoods, nil, 1.06, 1.06, 1, nil, 0.14)
	if not goodsT then
		goodsT = ComUtil.GetCom(goodsFadeT, "ActionFadeT")
	end
	goodsT:Play()
end

function OnGoodsUp()
	CSAPI.SetUIScaleTo(btnGoods, nil, 1, 1, 1, function()
		OnClickGoods()
	end, 0.15)
end

function OnClickGoods()
	if not CSAPI.IsViewOpen("ArchiveGoodsListView") then
		CSAPI.OpenView("ArchiveGoodsListView")
	end
end

function OnBoardDown()
	CSAPI.SetUIScaleTo(btnBoard, nil, 1.06, 1.06, 1, nil, 0.14)
	if not boardT then
		boardT = ComUtil.GetCom(boardFadeT, "ActionFadeT")
	end
	boardT:Play()
end

function OnBoardUp()
	CSAPI.SetUIScaleTo(btnBoard, nil, 1, 1, 1, function()
		OnClickBoard()
	end, 0.15)
end

function OnClickBoard()
	-- LanguageMgr:ShowTips(1000)
	-- CSAPI.OpenView("MulPictureView",1)
	local isNew = ArchiveMgr:GetIsNew(ArchiveType.Board)
	if isNew then
		CSAPI.SetGOActive(boardNew, false)
		SetIsNew(ArchiveType.Board)
	end
	if not CSAPI.IsViewOpen("ArchiveBoard") then
		CSAPI.OpenView("ArchiveBoard")
	end
end

function OnMusicDown()
	CSAPI.SetUIScaleTo(btnMusic, nil, 1.06, 1.06, 1, nil, 0.14)
	if not musicT then
		musicT = ComUtil.GetCom(musicFadeT, "ActionFadeT")
	end
	musicT:Play()
end

function OnMusicUp()
	CSAPI.SetUIScaleTo(btnMusic, nil, 1, 1, 1, function()
		OnClickMusic()
	end, 0.15)
end

function OnClickMusic()
	-- LanguageMgr:ShowTips(1000)
	-- CSAPI.OpenView("MulPictureView",1)
	local isNew = ArchiveMgr:GetIsNew(ArchiveType.Music)
	if isNew then
		CSAPI.SetGOActive(musicNew, false)
		SetIsNew(ArchiveType.Music)
	end
	if not CSAPI.IsViewOpen("BgmView") then
		CSAPI.OpenView("BgmView")
	end
	-- LanguageMgr:ShowTips(1000)
end

function OnAsmrDown()
	CSAPI.SetUIScaleTo(btnAsmr, nil, 1.06, 1.06, 1, nil, 0.14)
	if not asmrT then
		asmrT = ComUtil.GetCom(asmrFadeT, "ActionFadeT")
	end
	asmrT:Play()
end

function OnAsmrUp()
	CSAPI.SetUIScaleTo(btnAsmr, nil, 1, 1, 1, function()
		OnClickASMR()
	end, 0.15)
end

function OnClickASMR()
	-- LanguageMgr:ShowTips(1000)
	-- CSAPI.OpenView("MulPictureView",1)
	local isNew = ArchiveMgr:GetIsNew(ArchiveType.Asmr)
	if isNew then
		CSAPI.SetGOActive(asmrNew, false)
		SetIsNew(ArchiveType.Asmr)
	end
	if not CSAPI.IsViewOpen("ASMRView") then
		CSAPI.OpenView("ASMRView")
	end
	-- LanguageMgr:ShowTips(1000)
end
function OnSkinDown()
	CSAPI.SetUIScaleTo(btnSkin, nil, 1.06, 1.06, 1, nil, 0.14)
	if not skinT then
		skinT = ComUtil.GetCom(skinFadeT, "ActionFadeT")
	end
	skinT:Play()
end

function OnSkinUp()
	CSAPI.SetUIScaleTo(btnSkin, nil, 1, 1, 1, function()
		OnClickSkin()
	end, 0.15)
end

function OnClickSkin()
	local isNew = ArchiveMgr:GetIsNew(ArchiveType.Skin)
	if isNew then
		CSAPI.SetGOActive(skinNew, false)
		SetIsNew(ArchiveType.Skin)
	end
	if not CSAPI.IsViewOpen("SkinSetView") then
		CSAPI.OpenView("SkinSetView")
	end
end

function OnBiteDown()
	CSAPI.SetUIScaleTo(btnBite, nil, 1.06, 1.06, 1, nil, 0.14)
	if not biteT then
		biteT = ComUtil.GetCom(biteFadeT, "ActionFadeT")
	end
	biteT:Play()
end

function OnBiteUp()
	CSAPI.SetUIScaleTo(btnBite, nil, 1, 1, 1, function()
		OnClickBite()
	end, 0.15)
end

function OnClickBite()
	local isNew = ArchiveMgr:GetIsNew(ArchiveType.Bite)
	if isNew then
		CSAPI.SetGOActive(biteNew, false)
		SetIsNew(ArchiveType.Bite)
	end
	if not CSAPI.IsViewOpen("ArchiveBite") then
		CSAPI.OpenView("ArchiveBite")
	end
end

function OnStoryCollectionDown()
	CSAPI.SetUIScaleTo(btnStoryCollection, nil, 1.06, 1.06, 1, nil, 0.14)
	if not storyCollectionT then
		storyCollectionT = ComUtil.GetCom(storyCollectionFadeT, "ActionFadeT")
	end
	storyCollectionT:Play()
end

function OnStoryCollectionUp()
	CSAPI.SetUIScaleTo(btnStoryCollection, nil, 1, 1, 1, function()
		OnClickStoryCollection()
	end, 0.15)
end

function OnClickStoryCollection()
	local isNew = ArchiveMgr:GetIsNew(ArchiveType.StoryCollection)
	if isNew then
		-- CSAPI.SetGOActive(storyCollectionNew, false)
		SetIsNew(ArchiveType.StoryCollection)
	end
	if not CSAPI.IsViewOpen("StoryCollection") then
		CSAPI.OpenView("StoryCollection")
	end
end

function InitNew()
	ArchiveMgr:SetIsNew(ArchiveType.Asmr, ASMRMgr:IsRed())
	ArchiveMgr:SetIsNew(ArchiveType.StoryCollection, MissionMgr:CheckRed({eTaskType.StoryCollection}))

	for i = 1, #newName do
		if newName[i] ~= "" and this[newName[i]] then
			CSAPI.SetGOActive(this[newName[i]].gameObject, ArchiveMgr:GetIsNew(i))
		end
	end
end

function SetIsNew(type)
	ArchiveMgr:SetIsNew(type, false)
	ArchiveMgr:CheckRedPoint(type)
end

function OnDestroy()	
	ReleaseCSComRefs();
end
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
	---填写退出代码逻辑/接口
	if  top.OnClickBack then
		top.OnClickBack();
		if not UIMask then
			UIMask = CSAPI.GetGlobalGO("UIClickMask")
		end
		CSAPI.SetGOActive(UIMask, false)
	end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	txt1 = nil;
	this["txt1 (1)"] = nil;
	this["txt1 (2)"] = nil;
	btns = nil;
	btnRole = nil;
	txt_role = nil;
	this["txt_role (1)"] = nil;
	roleLine = nil;
	txtRoleNum1 = nil;
	txtRoleNum2 = nil;
	txtRoleNum3 = nil;
	roleNew = nil;
	btnEquip = nil;
	Text = nil;
	Text = nil;
	Text = nil;
	equipNew = nil;
	btnMemory = nil;
	txt_memory = nil;
	this["txt_memory (1)"] = nil;
	memoryLine = nil;
	txtMemoryNum1 = nil;
	txtMemoryNum2 = nil;
	txtMemoryNum3 = nil;
	txtMemoryNum3 = nil;
	memoryNew = nil;
	btnCourse = nil;
	txt_course = nil;
	this["txt_course (1)"] = nil;
	courseNew = nil;
	btnGoods = nil;
	txt_Goods = nil;
	this["txt_Goods (1)"] = nil;
	this["txt_Goods (2)"] = nil;
	goodsNew = nil;
	btnEnemy = nil;
	txt_Enemy = nil;
	this["txt_Enemy (1)"] = nil;
	enemyLine = nil;
	txtEnemyNum1 = nil;
	txtEnemyNum2 = nil;
	txtEnemyNum3 = nil;
	enemyNew = nil;
	roleFadeT = nil;
	memoryFadeT = nil;
	courseFadeT = nil;
	goodsFadeT = nil;
	enemyFadeT = nil;
	view = nil;
	this = nil;
end
----#End#----
