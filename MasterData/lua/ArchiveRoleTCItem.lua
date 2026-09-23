--台词item
local isSelect = false
local isOpen = false

function Awake()
	
end

function SetIndex(_index)
	index = _index
end

function SetClickCB(_cb)
	cb = _cb
end

--cfg :  CfgCardRoleVoice
function Refresh(_cfg, _elseData)
	cfg = _cfg
	openLv = cfg.openLv or 0
	isOpen = _elseData[1]:GetLv() >= openLv
	if cfg.type == RoleAudioType.perBreak or cfg.type == RoleAudioType.maxBreak then
		isOpen = GetBreakOpen(_elseData[1])
	end
	isSelect = _elseData[2] and _elseData[2] == cfg.id or false
	RefreshPanel()
end

function GetBreakOpen(roleInfo)
	local card = RoleMgr:GetData(roleInfo:GetFirstCardId())
	if card then
		if cfg.type == RoleAudioType.perBreak then
			return card:GetBreakLevel() > 1
		elseif cfg.type == RoleAudioType.maxBreak then
			return card:GetBreakLevel() >= 5
		end
	end
	return false
end

function RefreshPanel()
	CSAPI.SetText(txtDesc1, cfg.name)
	if not isOpen then
		CSAPI.SetGOActive(select, false)
		CSAPI.SetGOActive(normal, false)
		CSAPI.SetGOActive(lockObj,true)
		local languageId = 29067
		if cfg.type == RoleAudioType.perBreak then
			languageId = 29068
		elseif cfg.type == RoleAudioType.maxBreak then
			languageId = 29069
		end
		CSAPI.SetText(txtLock, LanguageMgr:GetByID(languageId, openLv))
		CSAPI.SetImgColor(bg,255,255,255,125)
		CSAPI.SetImgColor(img,255,255,255,125)
		CSAPI.SetTextColor(txtDesc1,255,255,255,125)
	else
		--波浪线 todo
		CSAPI.SetGOActive(select, isSelect)
		CSAPI.SetGOActive(normal, not isSelect)
		CSAPI.SetGOActive(lockObj,false)
		CSAPI.SetImgColor(bg,255,255,255,255)
		CSAPI.SetImgColor(img,255,255,255,255)
		CSAPI.SetTextColor(txtDesc1,255,255,255,255)
	end
end

function OnClick()
	if not isOpen then
		local languageId = 29067
		if cfg.type == RoleAudioType.perBreak then
			languageId = 29068
		elseif cfg.type == RoleAudioType.maxBreak then
			languageId = 29069
		end
		Tips.ShowTips(LanguageMgr:GetByID(languageId, openLv))
		return
	end
	if(not isSelect and cb) then
		cb(this)
	end
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
node=nil;
normal=nil;
select=nil;
bg2=nil;
txtDesc1=nil;
txtLock=nil;
view=nil;
end
----#End#----