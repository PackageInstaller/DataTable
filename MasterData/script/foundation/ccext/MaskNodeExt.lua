-- chunkname: @/tmp/or_script/lua_compile/foundation/ccext/MaskNodeExt.lua

if not _G.cc then
	local cc = {}
	local MaskBeginNode = cc.MaskBeginNode

	if MaskBeginNode and MaskBeginNode.STENCIL ~= nil then
		if not MaskBeginNode.__rawCreate then
			local rawCreate = MaskBeginNode.create

			function MaskBeginNode:create(arg1, arg2)
				if type(arg1) == "userdata" then
					return rawCreate(self, MaskBeginNode.STENCIL, arg1)
				end

				return rawCreate(self, arg1, arg2)
			end
		end
	end
end
