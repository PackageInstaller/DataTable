-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DDKDiscreteProgressBar.lua

module("logic.extensions.darkdragonknife.view.DDKDiscreteProgressBar", package.seeall)

local DDKDiscreteProgressBar = class("DDKDiscreteProgressBar")

function DDKDiscreteProgressBar:ctor(slider)
	self._slider = slider
end

function DDKDiscreteProgressBar:setValue(array, curScore)
	local progressVal = 0
	local part = 1 / #array

	for k, v in ipairs(array) do
		if curScore < v then
			if k > 1 then
				if not array[k - 1] then
					local lastVal = 0
					local interval = v - lastVal
					local diff = curScore - lastVal

					progressVal = progressVal + part * diff / interval

					break
				end
			end
		else
			progressVal = progressVal + part
		end
	end

	self._slider:SetValue(progressVal)
end

return DDKDiscreteProgressBar
