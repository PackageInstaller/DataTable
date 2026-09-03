-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/view/CrusadeSweepResultMediator.lua

CrusadeSweepResultMediator = class("CrusadeSweepResultMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {
	["main.touchPanel"] = {
		ignoreClickAudio = true,
		func = "onSpeedUpSweep"
	}
}

function CrusadeSweepResultMediator:initialize()
	super.initialize(self)
end

function CrusadeSweepResultMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function CrusadeSweepResultMediator:onRemove()
	super.onRemove(self)
end

function CrusadeSweepResultMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByFullName("mListView")

	self._listView:setScrollBarEnabled(false)

	self._cloneCell = self._main:getChildByFullName("cloneCell")

	self._cloneCell:setVisible(false)

	self._touchPanel = self._main:getChildByFullName("touchPanel")
	self._sweepSuc = self._main:getChildByFullName("sweepSuc")

	self._sweepSuc:setVisible(false)
	self._sweepSuc:setOpacity(0)

	self._sureBtn = self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onOKClicked, self)
		}
	})

	local bgNode = self._main:getChildByFullName("bg")
	local tempNode = bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Crusade_UI20"),
		title1 = Strings:get("Crusade_UI20"),
		bgSize = {
			width = 837,
			height = 576
		}
	})
end

function CrusadeSweepResultMediator:enterWithData(data)
	self._data = data

	self:createTableView()
end

function CrusadeSweepResultMediator:createTableView()
	self._listView:removeAllChildren()

	local length = #self._data

	self._sweepCount = length

	for i = 1, length do
		local data = self._data[i]
		local cloneCell = self._cloneCell:clone()

		cloneCell:setVisible(true)
		cloneCell:posite(0, 0)

		local name = cloneCell:getChildByFullName("name")
		local icon = cloneCell:getChildByFullName("icon")

		icon:removeAllChildren()
		name:setString(data.name)
		GameStyle:setQualityText(name, data.quality, true)

		local rewards = data.rewards

		for i = 1, #rewards do
			local reward = rewards[i]
			local rewardIcon = IconFactory:createRewardIcon(reward, {
				isWidget = true
			})

			icon:addChild(rewardIcon)
			rewardIcon:setAnchorPoint(cc.p(0, 0.5))
			rewardIcon:setPosition(cc.p(8 + (i - 1) * 68, 38))
			rewardIcon:setScaleNotCascade(0.55)
			rewardIcon:setTag(i)
			IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})
			rewardIcon:setOpacity(0)
		end

		cloneCell:setOpacity(0)
		self._listView:pushBackCustomItem(cloneCell)
	end

	self._listView:jumpToPercentVertical(0)

	local function cellAction(cell)
		local itemPanel = cell:getChildByFullName("icon")
		local i = 1

		while true do
			local reward = itemPanel:getChildByTag(i)

			if reward then
				reward:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * (i - 1)), cc.FadeIn:create(0.15)))

				i = i + 1
			else
				break
			end
		end
	end

	self._touchPanel:setVisible(true)

	local container = self._listView:getInnerContainer()
	local moveToBottom = cc.MoveTo:create(length * 0.45, cc.p(0, 0))

	container:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), moveToBottom, cc.CallFunc:create(function()
		self._touchPanel:setVisible(false)
		self._sweepSuc:setVisible(true)
		self._sweepSuc:fadeIn({
			time = 0.2
		})
	end)))
	self._listView:runAction(cc.CallFunc:create(function()
		local items = self._listView:getItems()

		for k, v in pairs(items) do
			if k <= length then
				local delayTime = 0.2
				local fadeInTime = 0.1

				if k == 1 then
					delayTime = 0
					fadeInTime = 0.01
				end

				v:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime + 0.2 * (k - 1)), cc.FadeIn:create(fadeInTime)))
				performWithDelay(self._listView, function()
					cellAction(v)
				end, 0.1 + 0.45 * (k - 1))
			end
		end
	end))
end

function CrusadeSweepResultMediator:onSpeedUpSweep()
	self._touchPanel:setVisible(false)
	self._listView:stopAllActions()

	local items = self._listView:getItems()
	local remainTime = 0

	for k, v in pairs(items) do
		if k <= self._sweepCount then
			v:setOpacity(255)

			local itemPanel = v:getChildByName("icon")
			local i = 1

			while true do
				local reward = itemPanel:getChildByTag(i)

				if reward then
					if reward:getOpacity() > 0 then
						remainTime = k * 0.05
					end

					reward:setOpacity(255)

					i = i + 1
				else
					break
				end
			end
		end
	end

	local container = self._listView:getInnerContainer()

	container:stopAllActions()
	container:runAction(cc.Sequence:create(cc.MoveTo:create(0.5 - remainTime, cc.p(0, 0)), cc.CallFunc:create(function()
		self._sweepSuc:setVisible(true)
		self._sweepSuc:fadeIn({
			time = 0.2
		})
	end)))
end

function CrusadeSweepResultMediator:onOKClicked(sender, eventType)
	self:close()
end

function CrusadeSweepResultMediator:onCloseClicked(sender, eventType)
	self:close()
end
