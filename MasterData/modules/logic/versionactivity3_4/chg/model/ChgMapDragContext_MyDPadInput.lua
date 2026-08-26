-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgMapDragContext_MyDPadInput.lua

local abs = math.abs

module("modules.logic.versionactivity3_4.chg.model.ChgMapDragContext_MyDPadInput", package.seeall)

local ChgMapDragContext_MyDPadInput = class("ChgMapDragContext_MyDPadInput")
local kMinSqrDistance = 100

function ChgMapDragContext_MyDPadInput:ctor(root)
	self._root = root
	self._totalDelta = Vector2.New(0, 0)

	self:clear()
end

function ChgMapDragContext_MyDPadInput:clear()
	self._totalDelta:Set(0, 0)
end

function ChgMapDragContext_MyDPadInput:snapshot(frameData)
	self._totalDelta = self._totalDelta + frameData.deltaV2
end

function ChgMapDragContext_MyDPadInput:isValid()
	return self._totalDelta:SqrMagnitude() > kMinSqrDistance
end

function ChgMapDragContext_MyDPadInput:peak()
	local deltaV2 = self._totalDelta
	local absX = abs(deltaV2.x)
	local absY = abs(deltaV2.y)

	if absY < absX then
		if deltaV2.x > 0 then
			local var_5_0 = ChgEnum.Dir.Right

			if not ChgEnum.Dir.Right then
				var_5_0 = ChgEnum.Dir.Left

				if not ChgEnum.Dir.Left then
					if deltaV2.y > 0 then
						var_5_0 = ChgEnum.Dir.Up

						if not ChgEnum.Dir.Up then
							local eDir = ChgEnum.Dir.Down

							return eDir, deltaV2
						end
					end
				end
			end
		end
	end
end

function ChgMapDragContext_MyDPadInput:pop()
	local eDir, deltaV2 = self:peak()
	local outV2 = deltaV2:Clone()

	self:clear()

	return eDir, outV2
end

return ChgMapDragContext_MyDPadInput
