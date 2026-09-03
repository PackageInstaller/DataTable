-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/view/CrusadePassFloorMediator.lua

CrusadePassFloorMediator = class("CrusadePassFloorMediator", DmPopupViewMediator, _M)

CrusadePassFloorMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CrusadePassFloorMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")
CrusadePassFloorMediator:has("_crusade", {
	is = "r"
}):injectWith("Crusade")

local kBtnHandlers = {
	["main.getBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickClose"
	}
}

function CrusadePassFloorMediator:initialize()
	super.initialize(self)
end

function CrusadePassFloorMediator:dispose()
	super.dispose(self)
end

function CrusadePassFloorMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function CrusadePassFloorMediator:enterWithData(data)
	self._data = data

	self:initWidgetInfo()
	self:addRankAwardPanel()
	self:onAnimEffect()
end

function CrusadePassFloorMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._name = self._mainPanel:getChildByName("name")
	self._icon = self._mainPanel:getChildByName("icon")
end

function CrusadePassFloorMediator:addRankAwardPanel()
	local rewards = self._data.reward
	local namelbl, rarity = self._crusadeSystem:getRewardDataByFloorNum(self._data.floorNum)
	local key = 1

	for k, v in pairs(rewards) do
		local icon = IconFactory:createRewardIcon(rewards[k])

		icon:addTo(self._icon)
		icon:setName("reward" .. key)
		icon:setScale(0.7)
		icon:setPosition(cc.p(self._icon:getContentSize().width / 2 + (k - 1) * 100, self._icon:getContentSize().height + 190))

		local iconLight = IconFactory:createRewardIcon(rewards[k])

		iconLight:addTo(self._icon)
		iconLight:setName("light_" .. key)
		iconLight:setScale(0.7)
		iconLight:setPosition(cc.p(self._icon:getContentSize().width / 2 + (k - 1) * 100, self._icon:getContentSize().height + 190))

		key = key + 1
	end

	self._name:setString(namelbl)
	GameStyle:setQualityText(self._name, rarity, true)
end

function CrusadePassFloorMediator:onClickClose()
	self:close()
end

function CrusadePassFloorMediator:onAnimEffect()
	local yuanzhengtongguan = cc.MovieClip:create("yuanzhengtongguan_yuanzhengtongguan")
	local animNode = self._mainPanel:getChildByName("animNode")

	yuanzhengtongguan:addTo(animNode):center(animNode:getContentSize())
	yuanzhengtongguan:addCallbackAtFrame(23, function()
		yuanzhengtongguan:stop()
	end)

	local getBtn = self._mainPanel:getChildByFullName("getBtn")
	local getAct = yuanzhengtongguan:getChildByFullName("getAct")

	self:addAnimToNode(getBtn, getAct, yuanzhengtongguan)

	local Title1 = self._mainPanel:getChildByFullName("Title1")
	local TitleAct1 = yuanzhengtongguan:getChildByFullName("TitleAct1")

	self:addAnimToNode(Title1, TitleAct1, yuanzhengtongguan)

	local Title2 = self._mainPanel:getChildByFullName("Title2")
	local TitleAct2 = yuanzhengtongguan:getChildByFullName("TitleAct2")

	self:addAnimToNode(Title2, TitleAct2, yuanzhengtongguan)

	local name = self._mainPanel:getChildByFullName("name")
	local nameAct = yuanzhengtongguan:getChildByFullName("nameAct")

	self:addAnimToNode(name, nameAct, yuanzhengtongguan)

	for i = 1, 3 do
		local reward = self._icon:getChildByFullName("reward" .. i)
		local rewardAct = yuanzhengtongguan:getChildByFullName("reward_" .. i)

		if reward and rewardAct then
			self:addAnimToNode(reward, rewardAct, yuanzhengtongguan)
		end
	end

	for i = 1, 3 do
		local light = self._icon:getChildByFullName("light_" .. i)
		local lightAct = yuanzhengtongguan:getChildByFullName("light_" .. i)

		if light and lightAct then
			self:addAnimToNode(light, lightAct, yuanzhengtongguan)
		end
	end
end

function CrusadePassFloorMediator:addAnimToNode(node, donguzo, anim)
	local nodeToActionMap = {}

	nodeToActionMap[node] = donguzo

	local startFunc2, stopFunc2 = CommonUtils.bindNodeToActionNode(nodeToActionMap, node, false)

	startFunc2()
	anim:addCallbackAtFrame(30, function()
		stopFunc2()
	end)
end
