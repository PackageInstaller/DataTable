-- chunkname: @modules/common/others/simplelistcomp/SimpleListType.lua

module("modules.common.others.simplelistcomp.SimpleListType", package.seeall)

local _get = GameUtil.getUniqueTb()

return {
	ListScrollView = _get(),
	LuaMixScrollView = _get(),
	Custom = _get(),
	Custom_RootIsScrollRect = _get()
}
