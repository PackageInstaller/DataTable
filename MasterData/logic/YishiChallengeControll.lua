-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/controll/YishiChallengeControll.lua

module("logic.extensions.yishichallenge.controll.YishiChallengeControll", package.seeall)

local YishiChallengeControll = class("YishiChallengeControll", BaseController)

function YishiChallengeControll:ctor()
	return
end

function YishiChallengeControll:onInit()
	self:onReset()
end

function YishiChallengeControll:onReset()
	self._effctList = {}
end

function YishiChallengeControll:openYishiCustomFmt(challengeId, stage)
	CustomFmtController.instance:showMissionView(YishiChallengeModel.instance:getYishiCustomFmtMo(challengeId, stage))
end

function YishiChallengeControll:createEffect(view, path, parent, loop)
	local eff = UIEffectManager.instance:playEffect(view, "20230303/yishitiaozhan/" .. path .. ".prefab", nil, 0, 0, loop, false, nil, function(target, eff)
		local effGo = eff.effGo.transform

		goutil.addChildToParent(effGo, parent)
		Framework.TransformUtil.SetLocalPos(effGo, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(effGo, 1, 1, 1)
	end)
	local x, y, z = Framework.TransformUtil.GetPos(parent.transform, 0, 0, 0)

	eff:setPos(x, y, z)
	table.insert(self._effctList, eff)

	return eff
end

function YishiChallengeControll:stopEffect()
	for k, v in pairs(self._effctList) do
		UIEffectManager.instance:stopEffect(v)
	end
end

YishiChallengeControll.instance = YishiChallengeControll.New()

return YishiChallengeControll
