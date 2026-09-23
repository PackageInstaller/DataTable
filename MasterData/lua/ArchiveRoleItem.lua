function Refresh(_cfg)
	if(_cfg) then
		data = CRoleMgr:GetData(_cfg.id)
		CSAPI.SetGOActive(hei, data == nil)
		if(data) then
			SetIcon(data:GetFirstSkinId())
			--CSAPI.SetText(txtHad, "")
			SetHei(false)
		else
			local cfg = Cfgs.CardData:GetByID(_cfg.aModels)
			if(cfg) then
				SetIcon(cfg.model)
				--CSAPI.SetText(txtHad, StringConstant.archive13)
				SetHei(true)
			else
				LogError("模型表不存在id：" .. _cfg.aModels)
			end
		end
		--SetName(_cfg.sAliasName)
	end
end

function SetIcon(_modelID)
	if(_modelID) then

		-- 	local x = CSAPI.GetScale(icon)
		-- 	local x2 = x *(1.2)
		-- 	CSAPI.SetScale(icon, x2, x2, 1)
		-- end)
		local cfg = Cfgs.character:GetByID(_modelID)
		if(cfg) then
			ResUtil.CardIcon:Load(icon, cfg.Card_head)
		else
			LogError("模型表不存在id：" .. _modelID)
		end
	end
end

function SetName(_str)
	CSAPI.SetText(txtName, _str)
end

function SetHei(b)
	CSAPI.SetGOActive(hei, b)
end

function OnClick()
	if(data) then
		CSAPI.OpenView("ArchiveRole", data)
	else
		-- Tips.ShowTips(StringConstant.archive9)
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
icon=nil;
nameBg=nil;
txtName=nil;
hei=nil;
Image=nil;
view=nil;
end
----#End#----