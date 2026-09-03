-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/view/RecruitRewardMediator.lua

RecruitRewardMediator = class("RecruitRewardMediator", DmPopupViewMediator, _M)

RecruitRewardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
RecruitRewardMediator:has("_recruitSystem", {
	is = "r"
}):injectWith("RecruitSystem")

local kBtnHandlers = {}

function RecruitRewardMediator:initialize()
	super.initialize(self)
end

function RecruitRewardMediator:dispose()
	super.dispose(self)
end

function RecruitRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._roleNode = self._main:getChildByName("roleNode")
	self._roundCount = self._main:getChildByName("roundCount")
	self._rewardCount = self._main:getChildByName("rewardCount")
	self._cellClone = self:getView():getChildByName("cellClone")
	self._rewardNode = self._main:getChildByName("rewardNode")

	self._cellClone:setVisible(false)

	self._rewardItemNode = {}
end

function RecruitRewardMediator:enterWithData(data)
	self:initData(data)
	self:initView(true)
end

function RecruitRewardMediator:initData(data)
	self._data = data.recruitData
end

function RecruitRewardMediator:initView(init)
	local bateInfo = self._data:getRebate()

	if #bateInfo == 0 then
		return
	end

	for index, info in ipairs(bateInfo) do
		local count = tonumber(info.count)
		local reward = info.reward

		if not self._rewardItemNode[index] then
			local node = self._cellClone:clone()

			node:setVisible(true)
			node:addTo(self._rewardNode)
			node:setPosition(cc.p((index - 1) * 138 + 75, -10))
			node:setLocalZOrder(99 - index)

			local redPoint = RedPoint:createDefaultNode()

			redPoint:addTo(node):posite(132, 105)
			redPoint:setLocalZOrder(999)
			redPoint:setName("redPoint")

			self._rewardItemNode[index] = node
		end

		local node = self._rewardItemNode[index]
		local cellClone = node:getChildByName("cellClone")

		cellClone:setColor(cc.c3b(255, 255, 255))

		local itemPanel = cellClone:getChildByName("itemPanel")

		itemPanel:removeAllChildren()

		local rewards = ConfigReader:getDataByNameIdAndKey("Reward", reward, "Content")

		for key, value in pairs(rewards) do
			local icon = IconFactory:createRewardIcon(value, {
				isWidget = true
			})

			icon:addTo(itemPanel, 1):center(itemPanel:getContentSize())
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), value, {
				needDelay = true
			})
			icon:setScaleNotCascade(index == 5 and 0.8 or 0.6)
		end

		cellClone:getChildByName("rewardItemCount"):setString(Strings:get("DrawCardRewardItemCount", {
			count = count
		}))
		cellClone:getChildByName("bg1"):setVisible(index == 5)

		local bg = cellClone:getChildByName("bg")

		bg:setScale(index == 5 and 1 or 0.75)
		bg:loadTexture("asset/common/tgjl_bg_icondi_1.png", ccui.TextureResType.localType)

		local line = cellClone:getChildByName("line")

		line:setVisible(false)

		local gotImg = node:getChildByName("gotImg")

		gotImg:setVisible(false)

		if info.status == DrawCardRewardStatus.FinishNotGet then
			line:setVisible(true)
			bg:loadTexture("asset/common/tgjl_bg_icondi_2.png", ccui.TextureResType.localType)

			local function callFunc(sender, eventType)
				local function callback()
					if self._data:getBateRound() > self._data:getRebateRoundLimit() then
						self:dispatch(ShowTipEvent({
							duration = 0.2,
							tip = Strings:get("DrawCard_Rebate_Over_Limit")
						}))
						self:close()

						return
					end

					self:initView()
				end

				self._recruitSystem:requestGetDrawCardCountReward({
					drawID = self._data:getId(),
					targetCount = sender.rewardData.count
				}, callback, true)
			end

			mapButtonHandlerClick(nil, itemPanel, {
				func = callFunc
			})

			itemPanel.rewardData = info
		elseif info.status == DrawCardRewardStatus.FinishGot then
			line:setVisible(true)
			cellClone:setColor(cc.c3b(127, 127, 127))
			gotImg:setVisible(true)
		end

		node:getChildByName("redPoint"):setVisible(info.redPoint)
	end

	if init then
		self._roleNode:removeAllChildren()

		local hero = self._data:getRoleDetail()[1].hero
		local roleModel = IconFactory:getRoleModelByKey("HeroBase", hero)
		local heroSprite = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = roleModel
		})

		heroSprite:setScale(0.9)
		heroSprite:addTo(self._roleNode)
		heroSprite:setPosition(cc.p(245, 270))
	end

	self._roundCount:setString(self._data:getBateRound())
	self._rewardCount:setString(self._data:getBateCount())
end
