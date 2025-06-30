-- chunkname: @IQIGame\\UIExternalApi\\ItemTipsApi.lua

ItemTipsApi = BaseLangApi:Extend()

function ItemTipsApi:GetBtnUseTxt()
	return "使用"
end

function ItemTipsApi:GetName(name, quality)
	return name
end

function ItemTipsApi:GetType(type, subType)
	local itemType = ""

	if type == 1 then
		return itemType .. self:GetCfgText(1211016)
	elseif type == 2 then
		if subType == 0 then
			return itemType .. self:GetCfgText(1211017)
		elseif subType == 1 then
			return itemType .. self:GetCfgText(1211018)
		elseif subType == 2 then
			return itemType .. self:GetCfgText(1211019)
		elseif subType == 3 then
			return itemType .. self:GetCfgText(1211020)
		elseif subType == 4 then
			return itemType .. self:GetCfgText(1211021)
		elseif subType == 5 then
			return itemType .. self:GetCfgText(1211022)
		elseif subType == 6 then
			return itemType .. self:GetCfgText(1211023)
		elseif subType == 7 then
			return itemType .. self:GetCfgText(1211024)
		elseif subType == 8 then
			return itemType .. self:GetCfgText(1211025)
		elseif subType == 9 then
			return itemType .. self:GetCfgText(1211026)
		elseif subType == 10 then
			return itemType .. self:GetCfgText(1211027)
		elseif subType == 11 then
			return itemType .. self:GetCfgText(1211028)
		elseif subType == 12 then
			return itemType .. self:GetCfgText(1211029)
		elseif subType == 13 then
			return itemType .. self:GetCfgText(1211030)
		elseif subType == 14 then
			return itemType .. self:GetCfgText(1211031)
		elseif subType == 15 then
			return itemType .. self:GetCfgText(1211032)
		elseif subType == 16 then
			return itemType .. self:GetCfgText(1211033)
		elseif subType == 17 then
			return itemType .. self:GetCfgText(1211034)
		elseif subType == 18 then
			return itemType .. self:GetCfgText(1211035)
		elseif subType == 19 then
			return itemType .. self:GetCfgText(1211058)
		elseif subType == 20 then
			return itemType .. self:GetCfgText(1211066)
		elseif subType == 21 then
			return itemType .. self:GetCfgText(1211067)
		elseif subType == 22 then
			return itemType .. self:GetCfgText(1211077)
		elseif subType == 23 then
			return ""
		elseif subType == 31 then
			return itemType .. self:GetCfgText(1211068)
		elseif subType == 32 then
			return itemType .. self:GetCfgText(1211069)
		elseif subType == 33 then
			return itemType .. self:GetCfgText(1211070)
		elseif subType == 34 then
			return itemType .. self:GetCfgText(1211071)
		elseif subType == 35 then
			return ""
		elseif subType == 36 then
			return itemType .. self:GetCfgText(1211078)
		elseif subType == 37 then
			return itemType .. self:GetCfgText(1211079)
		elseif subType == 100 then
			return itemType .. self:GetCfgText(1211080)
		elseif subType == 901 then
			return itemType .. self:GetCfgText(1211059)
		elseif subType == 902 then
			return itemType .. self:GetCfgText(1211060)
		elseif subType == 903 then
			return itemType .. self:GetCfgText(1211061)
		elseif subType == 904 then
			return itemType .. self:GetCfgText(1211062)
		elseif subType == 905 then
			return itemType .. self:GetCfgText(1211063)
		elseif subType == 906 then
			return itemType .. self:GetCfgText(1211064)
		elseif subType == 907 then
			return itemType .. self:GetCfgText(1211065)
		elseif subType == 908 then
			return itemType .. self:GetCfgText(1211076)
		elseif subType == 999 then
			return itemType .. "礼品"
		else
			return itemType .. self:GetCfgText(1211015)
		end
	elseif type == 3 then
		if subType == 1 then
			return itemType .. self:GetCfgText(1211036)
		elseif subType == 2 then
			return itemType .. self:GetCfgText(1211037)
		elseif subType == 3 then
			return itemType .. self:GetCfgText(1211038)
		elseif subType == 4 then
			return itemType .. self:GetCfgText(1211039)
		elseif subType == 5 then
			return itemType .. self:GetCfgText(1211040)
		elseif subType == 6 then
			return itemType .. self:GetCfgText(1211041)
		else
			return itemType .. self:GetCfgText(1211042)
		end
	elseif type == 4 then
		if subType == 1 then
			return itemType .. self:GetCfgText(1211043)
		elseif subType == 2 then
			return itemType .. self:GetCfgText(1211044)
		elseif subType == 3 then
			return itemType .. self:GetCfgText(1211045)
		elseif subType == 4 then
			return itemType .. self:GetCfgText(1211046)
		elseif subType == 5 then
			return itemType .. self:GetCfgText(1211047)
		else
			return itemType .. self:GetCfgText(1211048)
		end
	elseif type == 5 then
		if subType == 1 then
			return itemType .. self:GetCfgText(1211049)
		elseif subType == 2 then
			return itemType .. self:GetCfgText(1211050)
		elseif subType == 3 then
			return itemType .. self:GetCfgText(1211051)
		elseif subType == 4 then
			return itemType .. self:GetCfgText(1211052)
		elseif subType == 5 then
			return itemType .. self:GetCfgText(1211053)
		elseif subType == 6 then
			return itemType .. self:GetCfgText(1211054)
		elseif subType == 7 then
			return itemType .. self:GetCfgText(1211055)
		elseif subType == 8 then
			return itemType .. self:GetCfgText(1211056)
		elseif subType == 9 then
			return itemType .. self:GetCfgText(1211072)
		elseif subType == 10 then
			return itemType .. self:GetCfgText(1211081)
		elseif subType == 11 then
			return itemType .. self:GetCfgText(1211082)
		elseif subType == 12 then
			return itemType .. self:GetCfgText(1211083)
		elseif subType == 13 then
			return itemType .. "人偶预设解锁"
		else
			return itemType .. self:GetCfgText(1211015)
		end
	elseif type == 6 then
		if subType == 1 then
			return itemType .. self:GetCfgText(1211073)
		else
			return itemType .. self:GetCfgText(1211015)
		end
	elseif type == 8 then
		return itemType .. self:GetCfgText(1211057)
	else
		return itemType .. self:GetCfgText(1211015)
	end
end

function ItemTipsApi:GetDescTitle()
	return "描述"
end

function ItemTipsApi:GetSkillTitle()
	return "限制"
end

function ItemTipsApi:GetEquipTitle()
	return "套装效果"
end

function ItemTipsApi:GetDesc(desc)
	return desc
end

function ItemTipsApi:GetEffect(effect)
	return effect
end

function ItemTipsApi:GetUseArea(desc)
	return desc
end

function ItemTipsApi:GetUseCondition(condition)
	return condition
end

function ItemTipsApi:GetUseTimeTitle()
	return "使用时效"
end

function ItemTipsApi:GetUseTime(time)
	return time
end

function ItemTipsApi:GetCD(cd)
	return cd
end

function ItemTipsApi:GetUseCost(name, count)
	return name .. ":x" .. count
end

function ItemTipsApi:GetSourceTitle()
	return "来源"
end

function ItemTipsApi:GetSource(name)
	return name
end

function ItemTipsApi:GetHasCount(num)
	return "拥有:  " .. num
end

function ItemTipsApi:GetQualityBottomImg(quality)
	return string.format(self:GetResUrl(1100007), quality)
end

function ItemTipsApi:GetEquipDesc(desc, type)
	if type == 2 then
		return "两件套:" .. self:SkillValueColor(desc, 2)
	elseif type == 4 then
		return "四件套:" .. self:SkillValueColor(desc, 2)
	else
		return self:SkillValueColor(desc, 2)
	end
end

function ItemTipsApi:GetUseLimitText(num)
	return "本次最大使用数量:" .. num
end

function ItemTipsApi:GetItemIipsDesc(tipsId)
	return self:GetCfgText(tipsId)
end

function ItemTipsApi:GetItemColorTitle(isOpen, title)
	if isOpen then
		return string.format(ColorCfg.Black, title)
	else
		return string.format(ColorCfg.White, title)
	end
end

function ItemTipsApi:GetItemChapterTitle(chapterName, title)
	return string.format("%s(%s)", chapterName, title)
end
