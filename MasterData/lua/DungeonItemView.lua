--章节项
local curSel = false
local leftLineWidths = {169, 127}
local rightLineWidths = {142, 94}
local canvasGroup = nil

function Awake()
	txtChapter = ComUtil.GetCom(chapter, "Text");
	whiteFade = ComUtil.GetCom(fadeT, "ActionFadeT")
	canvasGroup = ComUtil.GetCom(content,"CanvasGroup")
end

function OnEnable()
	SetSel(false)
end

function SetClickCallBack(callBack)	
	clickCallBack = callBack;
end

function Set(targetCfg)	
	if(targetCfg == nil) then
		return;
	end
	
	--cfg
	cfg = targetCfg;
	
	--bg
	CSAPI.SetGOActive(bg, true)
	ResUtil:LoadBigImg(bg, "UIs/SectionImg/bg1/" .. cfg.checkImage)
	--title	
	-- txtChapter.text = "STAGE " .. tostring(cfg.chapterID)	
	txtChapter.text = LanguageMgr:GetByID(15124).. tostring(cfg.chapterID)
	local titleStr = IsOpen() and cfg.name or ""
	CSAPI.SetText(txtTitle, titleStr)
	
	--branch
	local strID = 0
	local color = {255, 193, 64, 255}
	if IsSub() then --支线
		strID = 6002
		color = {163, 194, 235, 255}
	elseif IsTeaching() then --教程
		strID = 15045
		color = {163, 194, 235, 255}
	elseif IsStory() then --剧情
		strID = 15040
		color = {255, 255, 255, 255}
	else --主线
		strID = 6001
	end
	LanguageMgr:SetText(txtBranch, strID)
	CSAPI.SetTextColor(txtBranch, color[1], color[2], color[3], color[4])
	
	--state
	SetState()
	
	--pass
	local passStr = IsPass() and LanguageMgr:GetByID(15038) or LanguageMgr:GetByID(15039)
	CSAPI.SetText(txtState, passStr)	
	CSAPI.SetGOActive(txtState, not IsOpen())
	
	--plot
	CSAPI.SetGOActive(plotImg, IsStory())
	
	--hard
	CSAPI.SetGOActive(hardObj, cfg.type == eDuplicateType.MainElite)
end

--关卡状态
function SetState()
	local dungeonData = DungeonMgr:GetDungeonData(GetID());	
	local index = 0
	
	--lock
	local isLock = not IsOpen();
	
	--new
	local isNew = IsOpen() and dungeonData == nil
	
	--star
	local star = -1
	if not IsStory() then
		star = 0
		if dungeonData and dungeonData:IsPass()  then
			star = dungeonData:GetStar() or 0
		end

		local completeInfo = nil
		if dungeonData and dungeonData.data then
			completeInfo = dungeonData:GetNGrade()
		end
		local starInfos = DungeonUtil.GetStarInfo2(cfg.id, completeInfo);

		for i = 0, starObj.transform.childCount - 1 do
			local go = starObj.transform:GetChild(i).gameObject
			local isComplete = starInfos[i + 1].isComplete
			local color = isComplete and{255,193,70,255} or {255,255,255,127}
			CSAPI.SetImgColor(go, color[1], color[2], color[3], color[4])
		end
	end
	
	if isLock then
		index = 1
	elseif isNew then
		index = 2
	else
		index = 3
	end
	
	canvasGroup.alpha = index == 1 and 0.5 or 1
	CSAPI.SetGOActive(lockObj, index == 1)
	CSAPI.SetGOActive(newObj, index == 2)
	CSAPI.SetGOActive(starObj, index > 1 and star >= 0)
	-- CSAPI.SetGOActive(line, not(index == 3 and star >= 0))	
end

function SetSel(isSel)
	if isSel then
		whiteFade:Play()
	end
	CSAPI.SetGOActive(selObj, isSel)
	CSAPI.SetGOActive(nolObj, not isSel)
end

function SetNext(isNext)
	CSAPI.SetGOActive(nextImg, isNext)
end

function SetSort(index)
	transform:SetSiblingIndex(index)
end

function GetSort()
	return transform:GetSiblingIndex()
end
--cfg
function GetCfg()
	return cfg;
end

--id
function GetID()
	return cfg.id;
end

--返回出战队伍数量
function GetTeamNum()
	return cfg and cfg.teamNum or 1;
end

function GetType()
	local type= DungeonInfoType.Normal
	if IsStory() then
		type = DungeonInfoType.Plot
	end
	return type
end

--开启
function IsOpen()
	local isOpen = false
	if cfg and cfg.id and DungeonMgr:IsDungeonOpen(cfg.id) then
		isOpen = IsFinishMission()
	end
	return isOpen;
end

function IsFinishMission()
	if cfg and cfg.LockMission then
		local finishNum = 0
		for i, v in ipairs(cfg.LockMission) do
			if v[1] == eTaskType.GuideStage and v[2] < MissionMgr:GetGuideIndex() then
				finishNum = finishNum + 1
			end
		end
		return finishNum >= #cfg.LockMission
	end
	return true
end

--通关
function IsPass()
	return cfg and DungeonMgr:CheckDungeonPass(GetID());
end

--剧情关卡
function IsStory()
	return cfg and cfg.sub_type == DungeonFlagType.Story;
end

--支线
function IsSub()
	return cfg and cfg.type == eDuplicateType.SubLine;
end
--教程
function IsTeaching()
	return cfg and cfg.type == eDuplicateType.Teaching;
end

--直接战斗
function IsFight()
	return cfg and cfg.nGroupID ~= nil
end

--主线关卡
function IsMainLine()
	if(cfg and(cfg.type == eDuplicateType.MainNormal or cfg.type == eDuplicateType.MainElite)) then
		return true
	end
	return false
end

function OnClick()
	--    Log( "点击副本");
	--    Log( cfg);
	local isOpen = IsOpen()
	if isOpen then
		if not imgFadeT then
			imgFadeT = ComUtil.GetCom(fadeT.gameObject, "ActionFadeT")
		end
		imgFadeT:Play()
		if(clickCallBack) then
			clickCallBack(this);
		end
	else
		if cfg.LockMission and not IsFinishMission() then --只处理阶段任务未完成
			local lockInfo = cfg.LockMission[1]
			local dialogData = {}
			dialogData.content = LanguageMgr:GetByID(15107,lockInfo[2] + 1, cfg.chapterID .. " " .. cfg.name)
			dialogData.okCallBack = function()
				JumpMgr:Jump(180002)
			end
			CSAPI.OpenView("Dialog", dialogData)
			return 
		end
		local preCfg = cfg.preChapterID and Cfgs.MainLine:GetByID(cfg.preChapterID[1]) or nil
		if preCfg then
			local str = preCfg.chapterID .. " " .. preCfg.name
			LanguageMgr:ShowTips(25003,str)
		end
	end
end

-----------------------------------遗弃--------------------------------------------------
--[[--章节数据
function GetSectionData()
	return DungeonMgr:GetSectionData(cfg.group);
end

--获取章节类型
function GetSectionType()
	local sectionData = GetSectionData();
	return sectionData:GetSectionType();
end
--]]
function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	node = nil;
	bg = nil;
	content = nil;
	selImg = nil;
	chapter = nil;
	txtTitle = nil;
	txtBranch = nil;
	lockObj = nil;
	newObj = nil;
	txtNew = nil;
	starObj = nil;
	stars = nil;
	txtStar = nil;
	txtMaxStar = nil;
	txtState = nil;
	plotImg = nil;
	fadeT = nil;
	nextImg = nil;
	view = nil;
end
----#End#----
