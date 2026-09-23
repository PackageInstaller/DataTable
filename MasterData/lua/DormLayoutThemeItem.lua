--主题item
function Refresh(_data, _curThemeType)
	data = _data
	curThemeType = _curThemeType
	isEntity = data.id ~= - 1
	CSAPI.SetGOActive(bg, isEntity)
	CSAPI.SetGOActive(btnSave, not isEntity)
	if(isEntity) then
		SetEntity()
	end
end

function SetEntity()
	local name = ""
	if(curThemeType == ThemeType.Sys) then
		--系统主题
		local cfg = Cfgs.CfgFurnitureTheme:GetByID(data.id)
		canRemove = false
		name = cfg.sName
		ResUtil.Theme:Load(icon, cfg.id.."/"..cfg.id, true)
		CSAPI.SetScale(icon,1,1,1)
	else
		--保存的主题
		canRemove = true
		name = data.name
		DormIconUtil.SetIcon(icon,  data.img)
		CSAPI.SetScale(icon,0.3,0.3,1)
	end
	--name 
	CSAPI.SetText(txtName1, name)
	CSAPI.SetText(txtName2, "")
	--remove
	CSAPI.SetGOActive(btnRemove, canRemove)
end


--点击,显示详情
function OnClick()
	if(isEntity) then
		CSAPI.OpenView("DormLayoutThemeCof", {curThemeType, data})
	end
end

--保存自由主题
function OnClickSave()
	if(not isEntity) then
		CSAPI.OpenView("DormLayoutThemeSave")
	end
end

--移除保存的主题
function OnClickRemove()
	if(curThemeType == ThemeType.Save) then
		UIUtil:OpenDialog(LanguageMgr:GetTips(21005), function()		
			DormProto:UnSaveTheme(data.id)
		end)
	end
end

