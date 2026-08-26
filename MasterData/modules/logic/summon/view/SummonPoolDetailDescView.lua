-- chunkname: @modules/logic/summon/view/SummonPoolDetailDescView.lua

module("modules.logic.summon.view.SummonPoolDetailDescView", package.seeall)

local SummonPoolDetailDescView = class("SummonPoolDetailDescView", BaseView)

function SummonPoolDetailDescView:onInitView()
	self._goContent = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content")
	self._goinfoItem = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content/#go_infoItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonPoolDetailDescView:addEvents()
	return
end

function SummonPoolDetailDescView:removeEvents()
	return
end

function SummonPoolDetailDescView:_editableInitView()
	self._infoItemTab = self:getUserDataTb_()
	self._paragraphItems = self:getUserDataTb_()
end

function SummonPoolDetailDescView:onUpdateParam()
	self:onOpen()
end

function SummonPoolDetailDescView:onOpen()
	self._poolParam = SummonController.instance:getPoolInfo()
	self._poolDetailId = self._poolParam.poolDetailId
	self._poolId = self._poolParam.poolId
	self._summonSimulationActId = self._poolParam.summonSimulationActId

	local poolCo = SummonConfig.instance:getSummonPool(self._poolId)

	self._resultType = SummonMainModel.getResultType(poolCo)

	self:_refreshUI()
end

function SummonPoolDetailDescView:_refreshUI()
	local summonDesc = self:buildDesc()

	self:cleanParagraphs()

	self._probUpRareIds, self._probUpIds = SummonPoolDetailCategoryListModel.buildProbUpDict(self._poolId)

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

function SummonPoolDetailDescView:cleanParagraphs()
	for i = #self._paragraphItems, 1, -1 do
		gohelper.destroy(self._paragraphItems[i])

		self._paragraphItems[i] = nil
	end
end

function SummonPoolDetailDescView:buildDesc()
	local summonPollCo = SummonConfig.instance:getSummonPool(self._poolId)
	local poolDetailCo = SummonConfig.instance:getPoolDetailConfig(self._poolDetailId)
	local data = {}
	local summonSimulationConfig

	data[1] = summonPollCo.nameCn
	data[2] = summonPollCo.nameEn

	local baseIndex = 3
	local weightCos = string.split(summonPollCo.initWeight, "|")

	for _, weightCo in ipairs(weightCos) do
		local rareProb = string.splitToNumber(weightCo, "#")
		local rare, weight = rareProb[1] + 1, rareProb[2]
		local index = 6 - rare + baseIndex

		data[index] = weight / 100 .. "%"
	end

	data[8] = string.split(summonPollCo.awardTime, "|")[2]

	local desc = ""

	if self._summonSimulationActId then
		desc = CommonConfig.instance:getConstStr(SummonSimulationPickConfig.instance:getSummonConfigById(self._summonSimulationActId).constId)
		desc = GameUtil.getSubPlaceholderLuaLang(desc, data)

		return desc
	end

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

function SummonPoolDetailDescView:parseDesc(desc)
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

function SummonPoolDetailDescView:checkBuildProbUp(descTabItem)
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
	descTabItem.desc = desc
end

function SummonPoolDetailDescView:splitParagraph(desc)
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

function SummonPoolDetailDescView:createParagraphUI(typeDef, str, itemGo)
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

function SummonPoolDetailDescView:descReplace(desc, pattern, replaceWord)
	for matchResult in desc:gmatch(pattern) do
		desc = string.gsub(desc, pattern, replaceWord)
	end

	return desc
end

function SummonPoolDetailDescView:getTargetName(id)
	if self._resultType == SummonEnum.ResultType.Char then
		local heroConfig = HeroConfig.instance:getHeroCO(id)

		return heroConfig.name
	elseif self._resultType == SummonEnum.ResultType.Equip then
		local equipConfig = EquipConfig.instance:getEquipCo(id)

		return equipConfig.name
	end

	return ""
end

function SummonPoolDetailDescView:onClose()
	return
end

function SummonPoolDetailDescView:onDestroyView()
	self._rateUpIcons = nil
	self._rateUpIconsPool = nil
end

return SummonPoolDetailDescView
