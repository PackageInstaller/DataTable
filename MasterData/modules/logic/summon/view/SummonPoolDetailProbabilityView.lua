-- chunkname: @modules/logic/summon/view/SummonPoolDetailProbabilityView.lua

module("modules.logic.summon.view.SummonPoolDetailProbabilityView", package.seeall)

local SummonPoolDetailProbabilityView = class("SummonPoolDetailProbabilityView", BaseView)

function SummonPoolDetailProbabilityView:onInitView()
	self._goContent = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content")
	self._goinfoItem = gohelper.findChild(self.viewGO, "infoScroll/Viewport/#go_Content/#go_infoItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonPoolDetailProbabilityView:addEvents()
	return
end

function SummonPoolDetailProbabilityView:removeEvents()
	return
end

function SummonPoolDetailProbabilityView:_editableInitView()
	self._infoItemTab = {}
end

function SummonPoolDetailProbabilityView:onUpdateParam()
	return
end

function SummonPoolDetailProbabilityView:onOpen()
	self._poolParam = SummonController.instance:getPoolInfo()
	self._poolId = self._poolParam.poolId
	self._poolDetailId = self._poolParam.poolDetailId
	self._poolAwardTime = self._poolParam.poolAwardTime
	self._summonSimulationActId = self._poolParam.summonSimulationActId
	self._maxAwardTime = string.splitToNumber(self._poolAwardTime, "|")[2]

	self:_refreshUI()
end

function SummonPoolDetailProbabilityView:_refreshUI()
	local poolDetailConfig = SummonConfig.instance:getPoolDetailConfig(self._poolDetailId)
	local originDesc = poolDetailConfig.desc

	if string.nilorempty(originDesc) then
		originDesc = CommonConfig.instance:getConstStr(ConstEnum.SummonPoolDetail)
	end

	local poolDetailDescs = string.split(originDesc, "#")
	local summonPoolConfig = SummonConfig.instance:getSummonPool(self._poolId)

	self._rareHeroNames = self:buildRareNameDict(summonPoolConfig)
	self._rareRates = self:buildRateRareDict(summonPoolConfig)

	local probabilityDesc

	if self._summonSimulationActId then
		local summonSimulationConfig = SummonSimulationPickConfig.instance:getSummonConfigById(self._summonSimulationActId)

		if summonSimulationConfig.heroExtraDesc then
			probabilityDesc = {}

			local datas = string.split(summonSimulationConfig.heroExtraDesc, "|")

			for _, singleDesc in ipairs(datas) do
				local data = string.split(singleDesc, "#")
				local rare = tonumber(data[1])
				local descName = data[2]

				probabilityDesc[rare] = luaLang(descName)
			end
		end
	end

	for k, desc in ipairs(poolDetailDescs) do
		local itemObj = self._infoItemTab[k]

		if not itemObj then
			itemObj = self:getUserDataTb_()
			itemObj.go = gohelper.clone(self._goinfoItem, self._goContent, "item" .. k)
			itemObj.txthero = gohelper.findChildText(itemObj.go, "#txt_descContent")
			itemObj.txtprobability = gohelper.findChildText(itemObj.go, "desctitle/#go_starList/probability/#txt_probability")
			itemObj.goprobup = gohelper.findChild(itemObj.go, "#go_probup")
			self._infoItemTab[k] = itemObj
		end

		gohelper.setActive(itemObj.go, true)
		self:_refreshSummonDesc(itemObj, desc, probabilityDesc)

		for i = 1, 6 do
			gohelper.setActive(gohelper.findChild(itemObj.go, "desctitle/#go_starList/star" .. i), i <= self._rate)
		end
	end
end

function SummonPoolDetailProbabilityView:_refreshSummonDesc(itemObj, desc, probabilityDesc)
	local txthero, txtprobability = itemObj.txthero, itemObj.txtprobability

	txthero.text = ""
	txtprobability.text = ""
	self._rate = 0
	desc = string.format(desc, self._maxAwardTime - 1, self._maxAwardTime)

	for matchResult in desc:gmatch("%[heroname=.-%]") do
		local i1, i2, p1, param, p3 = string.find(matchResult, "(%[heroname=)(.*)(%])")
		local rares = string.splitToNumber(param, "#")
		local replace = ""
		local replaceList = {}

		for i, rare in ipairs(rares) do
			if not self._rareHeroNames[rare] then
				local heroNames = {}
				local show = table.concat(heroNames, "|")

				table.insert(replaceList, show)
			end
		end

		replace = table.concat(replaceList, "|")
		matchResult = string.format("%s%s%s", "%[heroname=", param, "%]")
		desc = string.gsub(desc, matchResult, replace)
		txthero.text = string.format(replace)
	end

	for matchResult in desc:gmatch("%[rate=.-%]") do
		local i1, i2, p1, param, p3 = string.find(matchResult, "(%[rate=)(.*)(%])")
		local rares = string.splitToNumber(param, "#")
		local replace = 0

		for i, rare in ipairs(rares) do
			if not self._rareRates[rare] then
				local rate = 0

				replace = replace + rate
			end
		end

		local show = string.format("%s%%%%", replace * 100 - replace * 100 % 0.1)

		matchResult = string.format("%s%s%s", "%[rate=", param, "%]")
		desc = string.gsub(desc, matchResult, show)

		local showText = string.format(show)

		if probabilityDesc and #rares == 1 and probabilityDesc[rares[1]] then
			showText = showText .. probabilityDesc[rares[1]]
		end

		txtprobability.text = showText
		self._rate = CharacterEnum.Star[tonumber(param)]
	end
end

function SummonPoolDetailProbabilityView:buildRareNameDict(summonPoolConfig)
	local rareHeroNames = {}

	for i = 1, 5 do
		rareHeroNames[i] = {}
	end

	local resultType = SummonMainModel.getResultType(summonPoolConfig)
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

	return rareHeroNames
end

function SummonPoolDetailProbabilityView:buildRateRareDict(summonPoolConfig)
	local rareRates = {}
	local initWeight = summonPoolConfig.initWeight
	local weight

	if not string.nilorempty(initWeight) then
		local params = string.split(initWeight, "|")

		for i, param in ipairs(params) do
			weight = string.split(param, "#")

			local rare = tonumber(weight[1])

			rareRates[rare] = (tonumber(weight[2]) or 0) / 10000
		end
	end

	return rareRates
end

function SummonPoolDetailProbabilityView:onClose()
	return
end

function SummonPoolDetailProbabilityView:onDestroyView()
	return
end

return SummonPoolDetailProbabilityView
