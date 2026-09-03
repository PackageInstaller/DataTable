-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExplorePointBoxMediator.lua

require("dm.gameplay.popup.BaseRewardBoxMediator")

ExplorePointBoxMediator = class("ExplorePointBoxMediator", BaseRewardBoxMediator, _M)

function ExplorePointBoxMediator:initialize()
	super.initialize(self)
end

function ExplorePointBoxMediator:dispose()
	super.dispose(self)
end

function ExplorePointBoxMediator:onRegister()
	super.onRegister(self)
end

function ExplorePointBoxMediator:setupView(data)
	super.setupView(self, data)

	if data.got ~= nil then
		if not data.got then
			local got = false
			local rewardId = data.reward
			local rewards = RewardSystem:getRewardsById(rewardId)

			if rewards then
				self:addRewardIcons(rewards)
			end

			self._sureBtn:setVisible(not got)
			self._hasReceivedImg:setVisible(got)
			self._normalBoxInfo:setVisible(true)

			local descLabel = self._normalBoxInfo:getChildByFullName("desc_text")

			if not data.desc then
				descLabel:setString(data.desc)

				if data.taskValues then
					descLabel:setString("")
					descLabel:removeAllChildren()

					local taskValues = data.taskValues
					local currentValue = taskValues[#taskValues].currentValue
					local targetValue = taskValues[#taskValues].targetValue
					local str = Strings:get("EXPLORE_UI75", {
						desc = data.desc,
						currentValue = currentValue,
						targetValue = targetValue,
						fontName = TTF_FONT_FZYH_R
					})
					local desc = ccui.RichText:createWithXML(str, {})

					desc:addTo(descLabel)
					desc:setAnchorPoint(cc.p(0.5, 0.5))
					desc:setPosition(cc.p(0, 0))
				end
			end
		end
	end
end
