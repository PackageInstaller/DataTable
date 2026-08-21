-- chunkname: @IQIGame\\Net\\NetLibraryResponse.lua

function net_library.openLibraryResult(code, library)
	TownLibraryModule.OpenLibraryResult(library)
end

function net_library.viewNewsBookResult(code)
	TownLibraryModule.ViewNewsBookResult()
end

function net_library.getNewsBookRewardsResult(code, id, itemShows)
	TownLibraryModule.GetNewsBookRewardsResult(id, itemShows)
end
