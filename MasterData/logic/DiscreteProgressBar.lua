-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/DiscreteProgressBar.lua

module("logic.extensions.burygame.view.DiscreteProgressBar", package.seeall)

local DiscreteProgressBar = class("DiscreteProgressBar")

function DiscreteProgressBar:ctor(slider, gridLayout)
	self._slider = slider
	self._gridLayout = gridLayout
end

function DiscreteProgressBar:setValue(array, curScore)
	local prizeNum = #array
	local cellWidth = self._gridLayout.cellSize.x
	local spacingX = self._gridLayout.spacing.x
	local sliderRectTrans = self._slider:GetComponent(typeof(UnityEngine.RectTransform))
	local gridRectTrans = self._gridLayout:GetComponent(typeof(UnityEngine.RectTransform))
	local sizeDelta = sliderRectTrans.sizeDelta
	local barWidth = (cellWidth + spacingX) * prizeNum

	sizeDelta.x = barWidth
	sliderRectTrans.sizeDelta = sizeDelta

	Framework.TransformUtil.SetAnchoredPos(gridRectTrans, spacingX + cellWidth / 2, 0)

	local progressVal = 0

	for k, v in ipairs(array) do
		local score = v

		if curScore < score then
			if not array[k - 1] then
				progressVal = progressVal + (curScore - array[k - 1]) / (score - array[k - 1]) * (cellWidth + spacingX) / barWidth

				break
			end
		else
			progressVal = progressVal + (cellWidth + spacingX) / barWidth
		end
	end

	self._slider.value = progressVal

	return sliderRectTrans.sizeDelta.x
end

return DiscreteProgressBar
