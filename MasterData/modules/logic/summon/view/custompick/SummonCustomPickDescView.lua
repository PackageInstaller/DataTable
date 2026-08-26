-- chunkname: @modules/logic/summon/view/custompick/SummonCustomPickDescView.lua

module("modules.logic.summon.view.custompick.SummonCustomPickDescView", package.seeall)

local SummonCustomPickDescView = class("SummonCustomPickDescView", BaseView)

function SummonCustomPickDescView:onInitView()
	self._goContent = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content")
	self._goinfoItem = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content/#go_infoItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonCustomPickDescView:addEvents()
	return
end

function SummonCustomPickDescView:removeEvents()
	return
end

function SummonCustomPickDescView:_editableInitView()
	self._infoItemTab = self:getUserDataTb_()
	self._paragraphItems = self:getUserDataTb_()
end

function SummonCustomPickDescView:onUpdateParam()
	self:onOpen()
end

function SummonCustomPickDescView:onOpen()
	self._poolParam = SummonController.instance:getPoolInfo()
	self._poolDetailId = self._poolParam.poolDetailId
	self._poolId = self._poolParam.poolId

	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)

	self._resultType = SummonMainModel.getResultType(poolCo)
	self._nameDict = self:buildRareNameDict(poolCo)

	self:_refreshUI()
end

function SummonCustomPickDescView:_refreshUI()
	local summonDesc = self:buildDesc()

	self:cleanParagraphs()

	self._probUpIds = SummonPoolDetailCategoryListModel.buildCustomPickDict(self._poolId)

	local descTab = self:parseDesc(summonDesc)

	for k, descItem in ipairs(descTab) do
		local itemGo = self._infoItemTab[k]

		if not itemGo then
			itemGo = gohelper.clone(self._goinfoItem, self._goContent, "item" .. k)

			table.insert(self._infoItemTab, itemGo)
		end

		gohelper.setActive(itemGo, true)
		self:checkBuildProbUp(descItem)

		gohelper.findChildText(itemGo, "desctitle/#txt_desctitle").text = descItem.title

		local typeList, strList = self:splitParagraph(descItem.desc)

		if not typeList or #typeList == 0 then
			return
		end

		for i, typeDef in ipairs(typeList) do
			self:createParagraphUI(typeDef, strList[i] or "", itemGo)
		end
	end
end

function SummonCustomPickDescView:cleanParagraphs()
	for i = #self._paragraphItems, 1, -1 do
		gohelper.destroy(self._paragraphItems[i])

		self._paragraphItems[i] = nil
	end
end

function SummonCustomPickDescView:buildDesc()
	local summonPollCo = SummonConfig.instance:getSummonPool(self._poolId)
	local poolDetailCo = SummonConfig.instance:getPoolDetailConfig(self._poolDetailId)
	local data = {}

	data[1] = summonPollCo.nameCn
	data[2] = summonPollCo.nameEn

	local baseIndex = 3
	local weightCos = string.split(summonPollCo.initWeight, "|")

	for _, weightCo in ipairs(weightCos) do
		local rareProb = string.splitToNumber(weightCo, "#")
		local rare, weight = rareProb[1] + 1, rareProb[2]
		local index = 6 - rare + baseIndex

		data[index] = weight / 100 .. "%%"
	end

	data[8] = string.split(summonPollCo.awardTime, "|")[2]

	local desc = ""

	if poolDetailCo then
		local info = tonumber(poolDetailCo.info)

		if info then
			desc = CommonConfig.instance:getConstStr(info)
			desc = GameUtil.getSubPlaceholderLuaLang(desc, data)
		else
			logError(string.format("summon_pool_detail.info error! self._poolId = %s, detailId = %s", self._poolId, self._poolDetailId))
		end
	else
		logError(string.format("summon_pool_detail config not found ! self._poolId = %s, detailId = %s", self._poolId, self._poolDetailId))
	end

	return desc
end

function SummonCustomPickDescView:parseDesc(desc)
	local descTab = {}

	for title in string.gmatch(desc, "{(.-)}") do
		local descItem = {}

		descItem.title = title

		table.insert(descTab, descItem)
	end

	desc = string.gsub(desc, "{(.-)}", "|")

	local tempDescTab = string.split(desc, "|")

	for i = 2, #tempDescTab do
		descTab[i - 1].desc = tempDescTab[i]
	end

	return descTab
end

function SummonCustomPickDescView:checkBuildProbUp(descTabItem)
	local desc = descTabItem.desc

	for matchResult in desc:gmatch("%[upname=.-%]") do
		local i1, i2, p1, param, p3 = string.find(matchResult, "(%[upname=)(.*)(%])")
		local index = tonumber(param)
		local targetId = self._probUpIds[index]

		matchResult = string.format("%s%s%s", "%[upname=", param, "%]")
		desc = targetId and string.gsub(desc, matchResult, self:getTargetName(targetId)) or string.gsub(desc, matchResult, "")
	end

	desc = self:descReplace(desc, "%[ssr_up_rate%]", CommonConfig.instance:getConstNum(ConstEnum.SummonSSRUpProb) / 10 .. "%%")
	desc = self:descReplace(desc, "%[sr_up_rate%]", CommonConfig.instance:getConstNum(ConstEnum.SummonSRUpProb) / 10 .. "%%")
	desc = self._nameDict and self._nameDict[SummonEnum.CustomPickRare] and self:descReplace(desc, "%[all_six_star%]", table.concat(self._nameDict[SummonEnum.CustomPickRare], "|")) or self:descReplace(desc, "%[all_six_star%]", "")
	descTabItem.desc = desc
end

function SummonCustomPickDescView:splitParagraph(desc)
	local resultTypeList = {}
	local resultStrList = {}
	local remainStr = desc

	while not string.nilorempty(remainStr) do
		local startIndex, endIndex, param1, param2 = string.find(remainStr, "%[para=(%d-)%](.-)%[/para%]")

		if startIndex == nil then
			table.insert(resultTypeList, SummonEnum.DetailParagraphType.Normal)
			table.insert(resultStrList, remainStr)

			break
		end

		local subStr = string.sub(remainStr, 0, startIndex - 1)

		if not string.nilorempty(subStr) then
			table.insert(resultTypeList, SummonEnum.DetailParagraphType.Normal)
			table.insert(resultStrList, subStr)
		end

		if not string.nilorempty(param2) then
			table.insert(resultTypeList, tonumber(param1))
			table.insert(resultStrList, tostring(param2))
		end

		remainStr = string.sub(remainStr, endIndex + 1)

		if string.find(remainStr, "\n") == 1 then
			remainStr = string.sub(remainStr, 2)
		end
	end

	return resultTypeList, resultStrList
end

function SummonCustomPickDescView:createParagraphUI(typeDef, str, itemGo)
	local goItem

	if typeDef == SummonEnum.DetailParagraphType.SpaceOne then
		local goTarget = gohelper.findChild(itemGo, "#txt_descspaceone")

		goItem = gohelper.cloneInPlace(goTarget, "para_2")

		local textItem = goItem:GetComponent(gohelper.Type_TextMesh)

		textItem.text = str
	else
		local goTarget = gohelper.findChild(itemGo, "#txt_descContent")

		goItem = gohelper.cloneInPlace(goTarget, "para_1")

		local textItem = goItem:GetComponent(gohelper.Type_TextMesh)

		textItem.text = str
	end

	table.insert(self._paragraphItems, goItem)

	if not gohelper.isNil(goItem) then
		gohelper.setActive(goItem, true)
	end
end

function SummonCustomPickDescView:descReplace(desc, pattern, replaceWord)
	for matchResult in desc:gmatch(pattern) do
		desc = string.gsub(desc, pattern, replaceWord)
	end

	return desc
end

function SummonCustomPickDescView:getTargetName(id)
	if self._resultType == SummonEnum.ResultType.Char then
		local heroConfig = HeroConfig.instance:getHeroCO(id)

		return heroConfig.name
	elseif self._resultType == SummonEnum.ResultType.Equip then
		local equipConfig = EquipConfig.instance:getEquipCo(id)

		return equipConfig.name
	end

	return ""
end

function SummonCustomPickDescView:buildRareNameDict(summonPoolConfig)
	local rareHeroNames = {}

	for i = 1, 5 do
		rareHeroNames[i] = {}
	end

	local resultType = SummonMainModel.getResultType(summonPoolConfig)
	local summonPoolCfg = SummonConfig.instance:getSummonPool(self._poolId)

	if summonPoolCfg.type == SummonEnum.Type.StrongCustomOnePick then
		local summonIdStr = summonPoolCfg.param
		local summonIds = string.splitToNumber(summonIdStr, "#")

		for _, summonId in ipairs(summonIds) do
			local heroConfig = HeroConfig.instance:getHeroCO(summonId)
			local heroName = heroConfig.name

			table.insert(rareHeroNames[SummonEnum.CustomPickRare], heroName)
		end
	elseif summonPoolCfg.type == SummonEnum.Type.CustomPick and not string.nilorempty(summonPoolConfig.param2) then
		local summonIdStr = summonPoolCfg.param2
		local summonIds = string.splitToNumber(summonIdStr, "#")

		for _, summonId in ipairs(summonIds) do
			local heroConfig = HeroConfig.instance:getHeroCO(summonId)
			local heroName = heroConfig.name

			table.insert(rareHeroNames[SummonEnum.CustomPickRare], heroName)
		end
	else
		local rare2Cfg = SummonConfig.instance:getSummon(self._poolId)

		for rare, summonCfg in pairs(rare2Cfg) do
			local summonIdStr = summonCfg.summonId
			local summonIds = string.splitToNumber(summonIdStr, "#")

			for _, summonId in ipairs(summonIds) do
				if resultType == SummonEnum.ResultType.Char then
					local heroConfig = HeroConfig.instance:getHeroCO(summonId)
					local heroName = heroConfig.name

					table.insert(rareHeroNames[rare], heroName)
				elseif resultType == SummonEnum.ResultType.Equip then
					local equipConfig = EquipConfig.instance:getEquipCo(summonId)
					local equipName = equipConfig.name

					table.insert(rareHeroNames[rare], equipName)
				end
			end
		end
	end

	return rareHeroNames
end

function SummonCustomPickDescView:onClose()
	return
end

function SummonCustomPickDescView:onDestroyView()
	self._rateUpIcons = nil
	self._rateUpIconsPool = nil
end

return SummonCustomPickDescView
