-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\JumpGuideManager.lua

local ResJumpGuide = require("ClientData/ResJumpGuide")
local ResUIData = require("ClientData/ResUIData")
local JumpGuideManager = {}
local EventConst = require("EventConst")
local self = JumpGuideManager

function JumpGuideManager.jump(guideId, sourceUIName, ...)
	if not JumpGuideManager.checkCanJump(guideId, true) then
		return
	end

	local guideInfo = ResJumpGuide[guideId]
	local targetUIName = guideInfo.param_1
	local openUI = true
	local uiData = UIConst.UIMap[targetUIName]

	if uiData and uiData.need_state_name and uiData.need_state_name ~= "" and not GameFsm.isInState(uiData.need_state_name) then
		openUI = false

		GameFsm.translateState(uiData.need_state_name, {
			Const.STATE_ENTER_REASON_JUMP,
			{
				guideId,
				sourceUIName,
				...
			}
		})
	end

	if openUI then
		if sourceUIName ~= nil then
			UIManager.getUI(sourceUIName, false, false)
		end

		if uiData then
			self._jumpUI(guideInfo, ...)
		elseif CurAvatar and CurAvatar[targetUIName] then
			CurAvatar[targetUIName](CurAvatar, guideInfo.param_2, guideInfo.param_3)
		end
	end

	EventCenter.sendEvent(EventConst.JUMP_GUIDE, guideId, sourceUIName, ...)
end

function JumpGuideManager._jumpUI(guideInfo, ...)
	if not guideInfo or not guideInfo.param_1 then
		return
	end

	local uiName = guideInfo.param_1
	local jumpUIDlg = UIManager.tryGetUI(uiName)

	if jumpUIDlg then
		jumpUIDlg:allBindedWindowRelease()
	end

	local pageOperate = guideInfo.param_2
	local funcParam = guideInfo.param_3
	local targetUI = UIManager.getUI(uiName, true)

	if pageOperate and targetUI[pageOperate] then
		if tonumber(funcParam) then
			targetUI[pageOperate](targetUI, tonumber(funcParam), ...)
		elseif funcParam then
			targetUI[pageOperate](targetUI, funcParam, ...)
		else
			targetUI[pageOperate](targetUI, ...)
		end
	end
end

function JumpGuideManager.isConditionLimited(guideId)
	if not guideId or not ResJumpGuide[guideId] then
		return false
	end

	local guideInfo = ResJumpGuide[guideId]
	local checkCondition = guideInfo.condition

	if checkCondition and ConditionLimitManager.inLimitState(checkCondition) then
		return true, ConditionLimitManager.getLimitUnlockDesc(checkCondition)
	end

	return false
end

function JumpGuideManager.checkAttendantGrow(guideInfo, arg)
	local attendantId = tonumber(guideInfo.param_3)

	if attendantId then
		if GameContext.CurrentEntity and GameContext.CurrentEntity.attendantData and GameContext.CurrentEntity.attendantData[attendantId] and GameContext.CurrentEntity.attendantData[attendantId].active then
			return true
		end

		MsgManager.notice(Lang.get(30047))

		return false
	end

	return true
end

function JumpGuideManager.checkOpActiviyOpen(guideInfo, arg)
	local checkTemplateId = tonumber(guideInfo.param_3)
	local ce = GameContext.CurrentEntity
	local checkSuccess = false

	if checkTemplateId and ce then
		for opActId, displayInfo in pairs(ce.opActivityDisplayInfo) do
			if displayInfo.templateId == checkTemplateId then
				checkSuccess = ce:isOpActivityValid(opActId)

				break
			end
		end
	end

	if checkSuccess then
		return true
	else
		MsgManager.notice(Lang.get(30048))

		return false
	end
end

function JumpGuideManager.checkOpActivityTypeOpen(guideInfo, arg)
	local opActTypeId = tonumber(guideInfo.param_3) or 0
	local opActType = Const.OpActivityTypeEnum[opActTypeId]
	local ce = GameContext.CurrentEntity
	local checkSuccess = false

	if opActType and ce then
		for opActId, displayInfo in pairs(ce.opActivityDisplayInfo) do
			if displayInfo.opActType == opActType then
				checkSuccess = ce:isOpactivityTypeValid(opActType)

				break
			end
		end
	end

	if checkSuccess then
		return true
	else
		MsgManager.notice(Lang.get(30048))

		return false
	end
end

function JumpGuideManager.checkChildOpActivityOpen(guideInfo, arg)
	local param = guideInfo.param_3

	if param then
		local params = utils.splitString(param, ",")

		if params and params[1] then
			local newGuideInfo = {
				param_3 = params[1]
			}

			return self.checkOpActiviyOpen(newGuideInfo, arg)
		end
	end

	return false
end

function JumpGuideManager.checkMarryOpen(guideInfo, arg)
	local isMarryOpen = GameContext.CurrentEntity:getMarryState() ~= nil

	if isMarryOpen then
		return true
	else
		MsgManager.notice(Lang.get(30049))

		return false
	end
end

function JumpGuideManager.canJump(jumpId)
	local jumpData = ResJumpGuide[jumpId]

	if jumpData.param_1 == "jumpToShowActivity" then
		local actId = tonumber(jumpData.param_2)

		if actId and CurAvatar:isActivityValid(actId) then
			return true
		else
			return false
		end
	end

	return true
end

function JumpGuideManager.checkCanJump(guideId, checkTip)
	if guideId and not ResJumpGuide[guideId] then
		-- block empty
	end

	local guideInfo = ResJumpGuide[guideId]
	local checkCondition = guideInfo.condition

	if checkCondition and ConditionLimitManager.inLimitState(checkCondition) then
		if checkTip then
			MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(checkCondition))
		end

		return false
	end

	local checkFunc = guideInfo.check_func

	if checkFunc and CurAvatar[checkFunc] and not CurAvatar[checkFunc](CurAvatar) then
		if checkTip then
			MsgManager.notice(guideInfo.check_func_tip)
		end

		return false
	end

	local targetUIName = guideInfo.param_1

	if not targetUIName then
		return false
	end

	return true
end

return JumpGuideManager
