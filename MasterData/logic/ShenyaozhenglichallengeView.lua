-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaozhengli/view/ShenyaozhenglichallengeView.lua

module("logic.extensions.shenyaozhengli.view.ShenyaozhenglichallengeView", package.seeall)

local ShenyaozhenglichallengeView = class("ShenyaozhenglichallengeView", LordNoahChallengeView)

function ShenyaozhenglichallengeView:setShowTipsKey()
	self.LANG_TIPS_1 = "存活精灵：%s只"
	self.LANG_TIPS_2 = "累计存活精灵："
end

function ShenyaozhenglichallengeView:getFightEndMianViewName()
	return ViewName.ShenyaozhenglimainView
end

function ShenyaozhenglichallengeView:onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "shenyaozhenglichallengeview_rule")
end

return ShenyaozhenglichallengeView
