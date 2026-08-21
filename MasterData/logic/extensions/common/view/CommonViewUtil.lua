-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/CommonViewUtil.lua

module("logic.extensions.common.view.CommonViewUtil", package.seeall)

function calculate(current_step, configs, step_getter, progress_getter, initial_step, initial_progress)
	local k = 0

	for i, c in ipairs(configs) do
		if current_step <= step_getter(c) then
			k = i

			break
		end
	end

	if k == 0 then
		k = #configs
	end

	local right_step = step_getter(configs[k])
	local right_progress = progress_getter(configs[k], configs)
	local left_step = k > 1 and step_getter(configs[k - 1]) or initial_step
	local left_progress = k > 1 and progress_getter(configs[k - 1], configs) or initial_progress
	local p = (current_step - left_step) / (right_step - left_step)

	return left_progress + p * (right_progress - left_progress)
end
