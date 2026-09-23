
local isSmiple = false;
local isBoss = false;
local fade = nil;

function Awake()
	fade = ComUtil.GetCom(gameObject, "ActionFade")
end

function Refresh(_c, isSmiple)
	this.data = _c;
	if this.data then
		local modelCfg = Cfgs.character:GetByID(this.data.cfg.model);
		local iconName = nil;
		if modelCfg then
			iconName = modelCfg.icon
		end
		SetIcon(iconName);
		SetType(this.data.isBoss);
		SetSmiple(isSmiple);
	end
end

function SetType(_isBoss)
	isBoss = _isBoss;
	-- if isBoss then
	--     CSAPI.SetText(txt_bossLv,this.data.level .. "");
	-- else
	--     CSAPI.SetText(txt_lv,this.data.level .. "");
	-- end
end

function SetIcon(iconName)
	if iconName then
		CSAPI.SetGOActive(icon, true);
		ResUtil.RoleCard:Load(icon, iconName, true)
		-- CSAPI.SetScale(icon, 2, 2, 1)
	else
		CSAPI.SetGOActive(icon, false);
	end
end

function SetClickCB(cb)
	clickFunc = cb
end

function SetChoosie(isSelect)
	CSAPI.SetGOActive(choosieObj, isSelect);
end

function SetSmiple(isSmiple)
	if isSmiple then
		CSAPI.SetGOActive(bossObj, isBoss);
		CSAPI.SetGOActive(normalObj, false);
		CSAPI.SetGOActive(choosieObj, false);
	else
		CSAPI.SetGOActive(bossObj, isBoss);
		CSAPI.SetGOActive(normalObj, not isBoss);
		CSAPI.SetGOActive(choosieObj, false);
	end
end

function OnClickSelf()
	if clickFunc then
		clickFunc(this);
	end
	-- CSAPI.OpenView("EnemyInfo",this.data);
end

function PlayFade(idx)
	fade:Play(0, 1, 250, 200 + 100 * idx)
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
	bg = nil;
	icon = nil;
	bossObj = nil;
	txt_boss = nil;
	txt_bossLv = nil;
	txt_bossLv2 = nil;
	normalObj = nil;
	txt_lv = nil;
	txt_lv2 = nil;
	choosieObj = nil;
	view = nil;
end
----#End#----
