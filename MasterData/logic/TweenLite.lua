-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/TweenLite.lua

module("logic.extensions.family.view.TweenLite", package.seeall)

local TweenLite = {}
local math_min = math.min
local table_insert = table.insert

TweenLite.AnimType = {
	PosY = "PosY",
	FillAmount = "FillAmount",
	PosX = "PosX",
	NumAdd = "NumAdd"
}
TweenLite.moving_info_list = {}
TweenLite.moving_info_list_delay = {}
TweenLite.curr_info_index = 0
TweenLite.is_updating = false

function TweenLite.begin(refTarget, gameObject, tweentype, startvalue, endValue, AnimaTime, anim_end_func, tween_type, loop)
	if not gameObject then
		printInfo("gameObject is nil")

		return
	end

	local components = {}

	if tweentype == TweenLite.AnimType.FillAmount then
		components.imageCom = gameObject:GetComponent("Image")
		startvalue = startvalue or components.imageCom.fillAmount
	elseif tweentype == TweenLite.AnimType.PosY then
		local x, y, z

		if not startvalue then
			x, y, z = Framework.TransformUtil.GetLocalPos(gameObject.transform, 0, 0, 0)
		end

		startvalue = startvalue or y
	elseif tweentype == TweenLite.AnimType.NumAdd then
		components.textCom = gameObject:GetComponent("Text")
		startvalue = startvalue or checknumber(components.textCom.text)
	elseif tweentype == TweenLite.AnimType.PosX then
		local x, y, z

		if not startvalue then
			x, y, z = Framework.TransformUtil.GetLocalPos(gameObject.transform, 0, 0, 0)
		end

		startvalue = startvalue or x
	end

	local tid = TweenLite.addMovingItem(refTarget, gameObject, tweentype, startvalue, endValue, AnimaTime, anim_end_func, tween_type, loop, components)

	if not TweenLite.update_timer then
		settimer(0.02, TweenLite.update, TweenLite, true)

		TweenLite.update_timer = true
	end

	return tid
end

function TweenLite.setMovingInfo(v, progress)
	if not v or goutil.isNil(v.gameObject) then
		return true
	end

	local curr_value = v.startvalue + (v.endValue - v.startvalue) * progress

	if v.tweentype == TweenLite.AnimType.FillAmount then
		v.components.imageCom.fillAmount = curr_value
	elseif v.tweentype == TweenLite.AnimType.PosY then
		local x, y, z = Framework.TransformUtil.GetLocalPos(v.gameObject.transform, 0, 0, 0)

		GameUtil.setLocalPos(v.gameObject, x, curr_value, z)
	elseif v.tweentype == TweenLite.AnimType.NumAdd then
		v.components.textCom.text = math.floor(curr_value)
	elseif v.tweentype == TweenLite.AnimType.PosX then
		local x, y, z = Framework.TransformUtil.GetLocalPos(v.gameObject.transform, 0, 0, 0)

		GameUtil.setLocalPos(v.gameObject, curr_value, y, z)
	end

	return false
end

function TweenLite.addMovingItem(refTarget, gameObject, tweentype, startvalue, endValue, AnimaTime, anim_end_func, tween_type, loop, components)
	local info = {
		refTarget = refTarget,
		gameObject = gameObject,
		tweentype = tweentype,
		startvalue = startvalue,
		endValue = endValue,
		AnimaTime = AnimaTime,
		anim_end_func = anim_end_func,
		startTime = UnityEngine.Time.time,
		loop = loop or false,
		components = components
	}

	TweenLite.curr_info_index = TweenLite.curr_info_index + 1

	if TweenLite.is_updating == false then
		TweenLite.moving_info_list[TweenLite.curr_info_index] = info
	else
		TweenLite.moving_info_list_delay[TweenLite.curr_info_index] = info
	end

	return TweenLite.curr_info_index
end

function TweenLite.update()
	TweenLite.is_updating = true

	local delete_list = {}

	for k, v in pairs(TweenLite.moving_info_list) do
		local usetime = UnityEngine.Time.time - v.startTime
		local need_delete = false
		local ratio = math_min(usetime / v.AnimaTime, 1)

		need_delete = TweenLite.setMovingInfo(v, v.tween_func and v.tween_func(ratio) or ratio)

		local timeout = false

		if usetime >= v.AnimaTime then
			if v.loop then
				v.startTime = Status.NowTime
			else
				timeout = true
			end
		end

		if need_delete or timeout then
			if not need_delete and v.anim_end_func ~= nil then
				v.anim_end_func()
			end

			table_insert(delete_list, k)
		end
	end

	TweenLite.is_updating = false

	for i = 1, #delete_list do
		TweenLite.moving_info_list[delete_list[i]] = nil
	end

	for k, v in pairs(TweenLite.moving_info_list_delay) do
		v.startTime = UnityEngine.Time.time
		TweenLite.moving_info_list[k] = v
	end

	TweenLite.moving_info_list_delay = {}

	if table.nums(TweenLite.moving_info_list) <= 0 and TweenLite.update_timer then
		removetimer(TweenLite.update, TweenLite)

		TweenLite.update_timer = false
	end
end

function TweenLite.stop(id)
	if not id then
		return
	end

	TweenLite.moving_info_list[id] = nil
	TweenLite.moving_info_list_delay[id] = nil
end

return TweenLite
