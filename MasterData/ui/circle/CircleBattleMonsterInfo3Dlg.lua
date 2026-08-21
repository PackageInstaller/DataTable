-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleMonsterInfo3Dlg.lua

local CircleBattleMonsterInfo2Dlg = require("UI/Circle/CircleBattleMonsterInfo2Dlg")
local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local strClassName = "CircleBattleMonsterInfo3Dlg"
local CircleBattleMonsterInfo3Dlg = Class(strClassName, CircleBattleMonsterInfo2Dlg)

function CircleBattleMonsterInfo3Dlg:ctor(...)
	return
end

function CircleBattleMonsterInfo3Dlg:onBtnConfirmClick(...)
	if not self:preCheck() then
		return
	end

	self:setVisible(false)

	if CurAvatar.myCircle then
		local cur, total = CurAvatar.myCircle:getMonsterHpProgress(self.gridPos)

		if cur == 0 then
			-- block empty
		else
			local layer = CurAvatar.myCircle:getCurBattleLayer()
			local info = CurAvatar.myCircle:getCircleMember(CurAvatar.uid)

			if info then
				if info.battle_data.optype ~= Const.CIRCLE_PLAYER_STATE.FORMATION then
					local checkPath = CircleControlCenter.getMyServerCheckPath(self.gridPos)

					if checkPath then
						CurAvatar:tryCallCircleBattleRpc("clanBattleOccupyMonster", layer, self.gridPos - 1, checkPath)
					end
				else
					CircleControlCenter.checkMove(CurAvatar.uid, self.gridPos)
				end
			end
		end
	end
end

function CircleBattleMonsterInfo3Dlg:setSliderTxt(value)
	self.txtSliderNum:setText(string.format("%0.2f%%", value * 100))
end

return CircleBattleMonsterInfo3Dlg
