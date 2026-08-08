local pb = require "pb"
pb.option("no_default_values")
pb.option("encode_default_values")
local ProtoUtil = setmetatable({}, { __index = pb })
--local 

function ProtoUtil.register_file(path)
	
end

return ProtoUtil