local index = 0
local isUnLock = false
local lockIcon = ""
local canvasGroup = nil
local isNew = false

function Awake()
	canvasGroup = ComUtil.GetCom(node, "CanvasGroup")
end

function SetIndex(idx)
	index = idx
end

function OnDisable()
	if(isNew) then
		ArchiveMgr:SetNew(ArchiveType.Board, data.board_id, false)
	end
end

function Refresh(_data)
	data = _data
	if data then
		-- cfg = Cfgs.StoryInfo:GetByID(data.board_id)
		local str = ""
		if index < 10 then
			str = StringUtil:SetByColor(0, "FFFFFF") .. StringUtil:SetByColor(index, "FFC146")
		else
			str = StringUtil:SetByColor(index, "FFC146")
		end
		CSAPI.SetText(txtPercent, str)
		
		-- isUnLock = PlotMgr:IsPlayed(data.story_id)
		local mulPicInfo = MulPicMgr:GetData(data.board_id)
		if mulPicInfo then
			isUnLock = mulPicInfo:IsHad()
		end
		CSAPI.SetGOActive(unLockObj, isUnLock)
		CSAPI.SetGOActive(lockObj, not isUnLock)
		canvasGroup.alpha = isUnLock and 1 or 0.5
		
		--title
		CSAPI.SetText(txtTitle, mulPicInfo:GetName() or "")

		--tag
		CSAPI.SetGOActive(obj1, mulPicInfo:GetL2dName() ~= nil)
		CSAPI.SetGOActive(obj2, mulPicInfo:GetMv() ~= nil)
		CSAPI.SetGOActive(obj3, mulPicInfo:GetTag() ~= nil)
		
		--icon
		local iconName = isUnLock and data.icon or lockIcon
		if iconName ~= nil and iconName ~= "" then
			ResUtil.Archive:Load(icon,"MulPic/" .. iconName)
		end
		CSAPI.SetGOActive(icon, isUnLock) 
		
		--new 
		isNew = ArchiveMgr:GetNew(ArchiveType.Board, data.board_id)
		CSAPI.SetGOActive(new, isNew)
	end
end

function OnClick()
	if isUnLock then		
		CSAPI.OpenView("MulPictureView", {id=data.board_id,showMask=true})
	end
end
function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	icon = nil;
	txtPercent = nil;
	txtTitle = nil;
	view = nil;
end
----#End#----
