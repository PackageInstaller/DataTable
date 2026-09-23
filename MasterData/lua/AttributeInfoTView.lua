
local isDetail = true
function OnOpen()
	cardData = data
	baseData = cardData:GetBaseProperty()
	curStatusData = cardData:GetTotalProperty()
	SetStatus()
	--SetGrid()
	--SetBuff()
	SetSP()
	SetShield()
end

-- function SetGrid()
-- 	--grid
-- 	if(cardData:GetCfg().gridsIcon) then
-- 		ResUtil.RoleSkillGrid:Load(imgGrid, cardData:GetCfg().gridsIcon)
-- 	end
-- end

-- --光环
-- function SetBuff()
-- 	local haloID = cardData:GetCfg().halo
-- 	local cfg = haloID and Cfgs.cfgHalo:GetByID(haloID[1]) or nil
-- 	local types = cfg and cfg.use_types or {}
-- 	for i = 1, 2 do
-- 		if(#types >= i) then
-- 			local cfgPro = Cfgs.CfgCardPropertyEnum:GetByID(types[i])
-- 			CSAPI.SetText(this["txtBuff" .. i], cfgPro.sName)
-- 			local num = cfg[cfgPro.sFieldName] or 0
-- 			CSAPI.SetText(this["txtBuffNum" .. i], cfgPro.sFieldName == "speed" and "+" .. num or "+" .. math.floor((num * 100)) .. "%")
-- 		else
-- 			CSAPI.SetText(this["txtBuff" .. i], "")
-- 			CSAPI.SetText(this["txtBuffNum" .. i], "")
-- 		end
-- 	end
-- end

--属性  
function SetStatus()
	--属性条
	statusItems = statusItems or {}	
	statusDatas = {}
	for i, v in ipairs(g_RoleAttributeList) do
		local cfg = Cfgs.CfgCardPropertyEnum:GetByID(v)
		local key = cfg.sFieldName
		local _data = {}
		_data.id = v
		local val1 = baseData[key]
		local val2 = curStatusData[key]
		if(isDetail) then
			--1
			_data.val1 = GetBaseValue(key)
			--2
			if(val2 > val1) then
				_data.val2 = "+" .. RoleTool.GetStatusValueStr(key, val2 - val1)
			else
				_data.val2 = nil
			end
			--3
--_data.val3 = GetVal3(key)
		else
			_data.val1 = val2 > val1 and RoleTool.GetStatusValueStr(key, val2) or GetBaseValue(key)
			_data.val1Color = val2 > val1 and "00ffbf" or "FFFFFF"
		end
		_data.nobg = true
		table.insert(statusDatas, _data)
	end
	ItemUtil.AddItems("AttributeNew2/AttributeItem6", statusItems, statusDatas, statusGrids)
end

--当前未加成属性值
function GetBaseValue(_key)
	local num = baseData[_key]
	if(num) then
		return RoleTool.GetStatusValueStr(_key, num)
	end
	return ""
end

function SetSP()
	CSAPI.SetText(txtSP2, data:GetCurDataByKey("sp", true) .. "")
end

--护盾 (1物理，2光束)
function SetShield()
	local index = cardData:GetCfg().career
	local cfg = Cfgs.CfgCardPropertyEnum:GetByID(40 + index)
	local iconName = index == 1 and "img_12_02" or "img_12_01"
	CSAPI.LoadImg(imgShield, "UIs/Role/" .. iconName .. ".png", true, nil, true)
	CSAPI.SetText(txtShield2, cfg.sName)
end


-- function OnClickSwitch()
-- 	isDetail = not isDetail
-- 	SetStatus()
-- end

function OnClickMask()
	view:Close()
end 