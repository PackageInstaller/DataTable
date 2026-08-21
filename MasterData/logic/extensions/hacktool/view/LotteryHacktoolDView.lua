-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/LotteryHacktoolDView.lua

module("logic.extensions.hacktool.view.LotteryHacktoolDView", package.seeall)

local M = class("LotteryHacktoolDView")
local TabEnum = {
	Ten = 2,
	One = 1
}
local kOneKey = "lottery_hack_tool_one"
local kTenKey = "lottery_hack_tool_ten_%d"

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "btnClose"))
	self._btnCostom = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "btnGroup/btnCostom"))
	self._goTemplate = goutil.findChild(self._mainGo, "backpack_item")

	goutil.setActive(self._goTemplate, false)

	self._roleLayout = goutil.findChild(self._mainGo, "roleLayout")
	self._btnOne = goutil.findChildComponent(self._mainGo, "toggleGroup/btnOne", UIComponentType.SpaceXToggle)
	self._btnTen = goutil.findChildComponent(self._mainGo, "toggleGroup/btnTen", UIComponentType.SpaceXToggle)
	self._btnTest = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "btnTest"))
	self._iptHeroIds = UIComponentType.InputFieldAdapter(goutil.findChild(self._mainGo, "iptHeroID"))
	self._btnSave = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "btnSave"))
end

function M:onEnter()
	self:bindEvents()
	self:_setEvent(true)
	self:_initData()
	self:_onClickPanelOne()
end

function M:onExit()
	self:_unbindClickEvent()
	self:unbindEvents()
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		RetrieveDispatcher:addEventListener(RetrieveEventType.onTestLotteryCharacterChange, self._onTestLotteryCharacterChange, self)
	else
		RetrieveDispatcher:removeEventListener(RetrieveEventType.onTestLotteryCharacterChange, self._onTestLotteryCharacterChange, self)
	end
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCostom:AddClickListener(self._onClickCostom, self)
	self._btnOne:AddListener(self._onClickPanelOne, self)
	self._btnTen:AddListener(self._onClickPanelTen, self)
	self._btnTest:AddClickListener(self._onClickTest, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCostom:RemoveClickListener()
	self._btnOne:RemoveListener()
	self._btnTen:RemoveListener()
	self._btnTest:RemoveClickListener()
	self._btnSave:RemoveClickListener()
end

function M:_initData()
	self._oneData = {}
	self._tenData = {}

	local oneId = Astral.LocalStorage.Instance:GetInt(kOneKey, 2000011)

	table.insert(self._oneData, {
		isNew = true,
		itemCode = oneId
	})

	for i = 1, 10 do
		local tenId = Astral.LocalStorage.Instance:GetInt(string.format(kTenKey, i), 2000011)

		table.insert(self._tenData, {
			isNew = true,
			itemCode = tenId
		})
	end
end

function M:_onClickClose()
	goutil.setActive(self._mainGo, false)
end

function M:_onClickCostom()
	RetrieveController.instance:enterScene(true)

	if self._tabEnum == TabEnum.One then
		RetrieveController.instance:cacheLotteryResult(self._oneData)
	elseif self._tabEnum == TabEnum.Ten then
		RetrieveController.instance:cacheLotteryResult(self._tenData)
	end

	ViewMgr.instance:close(ViewName.HackToolView)
end

function M:_onClickPanelOne()
	self._tabEnum = TabEnum.One

	self:_refreshLayout()
end

function M:_onClickPanelTen()
	self._tabEnum = TabEnum.Ten

	self:_refreshLayout()
end

function M:_onClickTest()
	local conf = SpaceXFileUtil.ReadFile("Assets/Editor/Lottery/test.txt")

	conf = loadstring("return" .. conf)()

	local id = "20" .. string.sub(tostring(conf[1]), 2, -1)
	local oneData = {
		{
			isNew = true,
			itemCode = tonumber(id)
		}
	}
	local cacheKeyword = {
		code = conf[1],
		hint = conf[2],
		hintAilisi = conf[3],
		keyword1 = conf[4],
		keyword2 = conf[5],
		keyword3 = conf[6],
		keyword4 = conf[7],
		keyword5 = conf[8],
		keyword6 = conf[9],
		keyword7 = conf[10],
		keyword8 = conf[11]
	}

	LotteryLogModel.instance:setKeyword(cacheKeyword)
end

function M:_refreshLayout()
	self:_unbindClickEvent()
	goutil.clearChildren(self._roleLayout)

	if self._tabEnum == TabEnum.One then
		self:_addItem(self._oneData)
	elseif self._tabEnum == TabEnum.Ten then
		self:_addItem(self._tenData)
	end
end

function M:_unbindClickEvent()
	for i = 0, self._roleLayout.transform.childCount - 1 do
		local itemGo = self._roleLayout.transform:GetChild(i).gameObject
		local click = Astral.ButtonAdapter.Get(goutil.findChild(itemGo, "click"))

		click:RemoveClickListener()
	end
end

function M:_addItem(dataList)
	for i, data in ipairs(dataList) do
		local itemGo = goutil.clone(self._goTemplate, "item")

		goutil.setActive(itemGo, true)
		goutil.addChildToParent(itemGo, self._roleLayout)

		local imgQuality = goutil.findChildImageComponent(itemGo, "imgQuality")
		local imgIcon = goutil.findChildImageComponent(itemGo, "imgIcon")
		local click = Astral.ButtonAdapter.Get(goutil.findChild(itemGo, "click"))

		click:AddClickListener(function()
			ViewMgr.instance:open(ViewName.LotteryHacktoolSelect, i)
		end, self)

		local txtDown = goutil.findChildTextComponent(itemGo, "txtDown")
		local characterCO = CharacterConfig.instance:getCfgInfoByID(data.itemCode)
		local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(data.itemCode)
		local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

		IconLoader.setSprite(imgIcon, IconType.HeadIcon, modelCO.headIconName)
		IconLoader.setSprite(imgQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(characterCO.quality))

		txtDown.text = heroInfoCO.name
	end
end

function M:_onTestLotteryCharacterChange(e, index, characterCode)
	if self._tabEnum == TabEnum.One then
		self._oneData[index].itemCode = characterCode

		Astral.LocalStorage.Instance:SetInt(kOneKey, characterCode)
	elseif self._tabEnum == TabEnum.Ten then
		self._tenData[index].itemCode = characterCode

		Astral.LocalStorage.Instance:SetInt(string.format(kTenKey, index), characterCode)
	end

	self:_refreshLayout()
end

function M:_onClickSave()
	local heroIdStr = self._iptHeroIds:GetText()

	if self._tabEnum == TabEnum.One then
		local heroId = tonumber(heroIdStr)

		self:_onTestLotteryCharacterChange(nil, 1, heroId)
	elseif self._tabEnum == TabEnum.Ten then
		local heroIds = string.split(heroIdStr, "#")

		if #heroIds ~= 10 then
			printError("填写10个角色ID")

			return
		end

		for i = 1, 10 do
			local heroId = tonumber(heroIds[i])

			self:_onTestLotteryCharacterChange(nil, i, heroId)
		end
	end
end

return M
