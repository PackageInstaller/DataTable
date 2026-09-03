-- chunkname: @/tmp/or_skill/lua_compile/CLubBoss.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.ClubBoss_wild_1 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global
				local count = global.SpecialPropGetter(_env, "ClubBoss_wild")(_env, _env.ACTOR)

				if count == 0 then
					local buffeft1 = global.SpecialNumericEffect(_env, "+ClubBoss_wild", {
						"+Normal",
						"+Normal"
					}, 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "ClubBoss_wild_1",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+ClubBoss_wild", {
						"+Normal",
						"+Normal"
					}, count + 1)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "ClubBoss_wild_1",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end

				if count >= 2 then
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, 4)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "ClubBoss_wild_2",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}

	return _M
end
