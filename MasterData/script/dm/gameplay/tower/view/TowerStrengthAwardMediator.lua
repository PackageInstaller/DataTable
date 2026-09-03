-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerStrengthAwardMediator.lua

require("dm.gameplay.popup.BaseRewardBoxMediator")

TowerStrengthAwardMediator = class("TowerStrengthAwardMediator", BaseRewardBoxMediator, _M)

function TowerStrengthAwardMediator:initialize()
	super.initialize(self)
end

function TowerStrengthAwardMediator:dispose()
	super.dispose(self)
end

function TowerStrengthAwardMediator:onRegister()
	super.onRegister(self)
end

function TowerStrengthAwardMediator:setupView(data)
	self:getView():getChildByFullName("main.bestReward.desc_text_1"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self:getView():getChildByFullName("main.bestReward.desc_text_2"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self:getView():getChildByFullName("main.Text_1"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	data.title = "StageSp_Reward_Title"
	data.titleEn = "StageSp_Reward_EN_Title"

	super.setupView(self, data)

	local rewards = data
	local test = self:getView():getChildByFullName("main.Text_1")
	local str = Strings:get("Tower_New_UI_19")
	local strTab = string.split(str, "\\n")
	local newStr = ""

	for k, v in pairs(strTab) do
		newStr = newStr .. v

		if strTab[k + 1] then
			newStr = newStr .. "\n"
		end
	end

	test:setString(newStr)

	if rewards then
		self:addRewardIcons(rewards, rewardShowType.firstBig)
	end

	self._sureBtn:setVisible(true)

	local bgNode = self:getView():getChildByFullName("main.bg_node")

	bgNode:getChildByFullName("Image_bg4"):setVisible(true)
end
