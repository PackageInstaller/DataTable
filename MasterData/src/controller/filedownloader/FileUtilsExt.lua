local var_0_0 = cc.FileUtils:getInstance()

var_0_0.readJsonFile = var_0_0.haveDownloadAPI and function(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:getDataFromFile(arg_1_1)

	assert(var_1_0, "ReadJsonFile Error")

	return json.decode(var_1_0)
end or function()
	print("FileUtils Version Is Old, Need Update Client!!!!")
end
