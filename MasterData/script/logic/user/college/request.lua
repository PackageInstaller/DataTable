local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_CollageExpandReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.ClassroomExtendReq", {})
	end

	function arg_1_0.req_ReplaceTeacherReq(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.ReplaceTeacherReq", {
			teacher = arg_3_1.teacher,
			class = arg_3_1.class
		})
	end

	function arg_1_0.req_BeginToStudyReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.StartStudyReq", {
			class = arg_4_1.class,
			tactics = arg_4_1.tactics,
			ship = arg_4_1.ship,
			seat = arg_4_1.seat
		})
	end

	function arg_1_0.req_StopStudyReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.StopStudyReq", {
			class = arg_5_1.class,
			ship = arg_5_1.ship
		})
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
