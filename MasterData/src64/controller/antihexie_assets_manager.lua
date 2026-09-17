return {
	enableAntiHexie = function(self)
		if self:isAntiHexieNow() then
			return
		end

		cc.UserDefault:getInstance():setBoolForKey("antihexie", true)
		global_restart_game()
	end,
	isAntiHexieNow = function(arg_2_0)
		return cc.UserDefault:getInstance():getBoolForKey("antihexie", false)
	end
}
