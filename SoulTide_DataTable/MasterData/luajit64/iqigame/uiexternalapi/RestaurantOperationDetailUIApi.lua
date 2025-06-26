-- chunkname: @IQIGame\\UIExternalApi\\RestaurantOperationDetailUIApi.lua

RestaurantOperationDetailUIApi = BaseLangApi:Extend()

function RestaurantOperationDetailUIApi:Init()
	self:RegisterApi("TextLv", self.GetTextLv)
	self:RegisterApi("TextWorkerNum", self.GetTextWorkerNum)
	self:RegisterApi("TextTotalAttribute", self.GetTextTotalAttribute)
	self:RegisterApi("PostName", self.GetPostName)
	self:RegisterApi("PostMainAttr", self.GetPostMainAttr)
	self:RegisterApi("PostBuildingAttr", self.GetPostBuildingAttr)
	self:RegisterApi("TextConditionDes", self.GetTextConditionDes)
	self:RegisterApi("TextUpGradeValue", self.GetTextUpGradeValue)
	self:RegisterApi("TextLevelDes", self.GetTextLevelDes)
	self:RegisterApi("TextCome", self.GetTextCome)
	self:RegisterApi("TextPer", self.GetTextPer)
	self:RegisterApi("TextContent", self.GetTextContent)
end

function RestaurantOperationDetailUIApi:GetTextContent(count, rewardStr, success, value)
	if success then
		return string.format(self:GetCfgText(3810034), count, rewardStr)
	end

	return string.format(self:GetCfgText(3810035), count, rewardStr)
end

function RestaurantOperationDetailUIApi:GetTextPer(count, maxCount)
	return string.format(self:GetCfgText(3810031), count, maxCount)
end

function RestaurantOperationDetailUIApi:GetTextCome(name, value, cid)
	if cid == 7 then
		return string.format(self:GetCfgText(3810036), name, value)
	end

	return string.format(self:GetCfgText(3810032), name, value)
end

function RestaurantOperationDetailUIApi:GetTextLevelDes(num)
	return string.format(self:GetCfgText(3810033), num)
end

function RestaurantOperationDetailUIApi:GetTextUpGradeValue(needNum, haveNum)
	if needNum <= haveNum then
		return needNum
	end

	return self.TextColor[28] .. needNum .. self.TextColor[0]
end

function RestaurantOperationDetailUIApi:GetTextConditionDes(name, needValue, haveValue)
	if needValue <= haveValue then
		return string.format("%s ≥ <color=#26d26b>%s</color>", name, needValue)
	end

	return string.format("%s ≥ <color=#ff5757>%s</color>", name, needValue)
end

function RestaurantOperationDetailUIApi:GetPostBuildingAttr(value)
	return string.format("+ <color=#4c97dc>%s</color>", value)
end

function RestaurantOperationDetailUIApi:GetPostMainAttr(name, value)
	return string.format("%s: <color=#4c97dc>%s</color>", name, value)
end

function RestaurantOperationDetailUIApi:GetPostName(name, value)
	return string.format("%s: <color=#4c97dc>%s</color>", name, value)
end

function RestaurantOperationDetailUIApi:GetTextTotalAttribute(num)
	return string.format("%s", num)
end

function RestaurantOperationDetailUIApi:GetTextWorkerNum(num)
	return string.format("%s", num)
end

function RestaurantOperationDetailUIApi:GetTextLv(lv)
	return string.format("%s", lv)
end

RestaurantOperationDetailUIApi:Init()
