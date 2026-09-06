-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/tweens/UIFlyTween.lua

module("logiccommon.common.tweens.UIFlyTween", package.seeall)

local UIFlyTween = class("UIFlyTween")

function UIFlyTween:doFlyTween(uiFlyTweenParam)
	if not uiFlyTweenParam or not uiFlyTweenParam.targetGo then
		return
	end

	local targetGo = uiFlyTweenParam.targetGo

	if not uiFlyTweenParam.endPosition then
		local endPosition = Vector3.New(0, 0, 0)

		if not uiFlyTweenParam.endScale then
			local endScale = 0
			local onCompleteCallback = uiFlyTweenParam.onCompleteCallback

			if not uiFlyTweenParam.duration then
				local isKeepFinalResult = uiFlyTweenParam.isKeepFinalResult
				local transform = targetGo.transform
				local originPosition = transform.position
				local originLocalScale = transform.localScale
				local s = DG.Tweening.DOTween.Sequence()

				s:Append(transform:DOMove(uiFlyTweenParam.endPosition, uiFlyTweenParam.duration))
				s:Join(transform:DOScale(endScale, uiFlyTweenParam.duration))
				s:OnComplete(function()
					if not isKeepFinalResult and transform then
						transform.position = originPosition
						transform.localScale = originLocalScale
					end

					if onCompleteCallback then
						onCompleteCallback()
					end
				end)

				return s
			end
		end
	end
end

UIFlyTween.instance = UIFlyTween.New()

return UIFlyTween
