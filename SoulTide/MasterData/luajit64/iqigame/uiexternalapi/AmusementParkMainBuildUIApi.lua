-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkMainBuildUIApi.lua

AmusementParkMainBuildUIApi = BaseLangApi:Extend()

function AmusementParkMainBuildUIApi:Init()
	self:RegisterApi("TextContent", self.GetTextContent)
	self:RegisterApi("BuildNeedAttrCondition", self.GetBuildNeedAttrCondition)
	self:RegisterApi("BuildNeedBuildLvCondition", self.GetBuildNeedBuildLvCondition)
	self:RegisterApi("BuildCost", self.GetBuildCost)
	self:RegisterApi("BuildLv", self.GetBuildLv)
	self:RegisterApi("TextFeature", self.GetTextFeature)
	self:RegisterApi("BuildAttr", self.GetBuildAttr)
	self:RegisterApi("PlayerNum", self.GetPlayerNum)
	self:RegisterApi("AttrDes", self.GetAttrDes)
end

function AmusementParkMainBuildUIApi:GetAttrDes(num, name)
	if name == "魔物吸引量" or name == "魔物负载量" then
		return string.format("每点增加建筑%s <color=#3399cc>%s/m</color>", name, num)
	end

	return string.format("每点增加建筑%s <color=#3399cc>%s/人</color>", name, num)
end

function AmusementParkMainBuildUIApi:GetPlayerNum(num)
	return string.format(self:GetCfgText(3830060), num)
end

function AmusementParkMainBuildUIApi:GetBuildAttr(value, index)
	if index == 6 or index == 7 then
		return string.format("%s/人", value)
	end

	return string.format("%s/m", value)
end

function AmusementParkMainBuildUIApi:GetTextFeature(name, value, type)
	if type == 1 then
		return string.format("<color=#666666>相邻建筑%s:</color> +%s", name, value)
	end

	return string.format("<color=#666666>相邻建筑%s:</color> +%s%%", name, value)
end

function AmusementParkMainBuildUIApi:GetBuildLv(lv, maxLv)
	return string.format(self:GetCfgText(3830061), lv, maxLv)
end

function AmusementParkMainBuildUIApi:GetBuildCost(needNum, haveNum)
	if needNum <= haveNum then
		return string.format("嘉年华代币x%s", needNum)
	end

	return string.format("嘉年华代币x%s", needNum)
end

function AmusementParkMainBuildUIApi:GetBuildNeedBuildLvCondition(buildName, buildLv, needBuildLv)
	if needBuildLv <= buildLv then
		return string.format(self:GetCfgText(3830062), buildName, needBuildLv)
	end

	return string.format(self:GetCfgText(3830063), buildName, needBuildLv)
end

function AmusementParkMainBuildUIApi:GetBuildNeedAttrCondition(attrName, attrValue, needValue)
	if needValue <= attrValue then
		return string.format("%s>=%s", attrName, needValue)
	end

	return string.format("%s>=%s", attrName, needValue)
end

function AmusementParkMainBuildUIApi:GetTextContent(conditionStr, top)
	if top then
		return conditionStr
	end

	return conditionStr
end

AmusementParkMainBuildUIApi:Init()
