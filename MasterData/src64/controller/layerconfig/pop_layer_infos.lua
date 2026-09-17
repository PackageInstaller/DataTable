local var_0_0 = {}

for iter_0_0, iter_0_1 in pairs({
	"controller.layerconfig.pop_layer_old_infos",
	"controller.layerconfig.pop_layer_hx_infos",
	"controller.layerconfig.pop_layer_cn_infos",
	"controller.layerconfig.pop_layer_jp_infos",
	"controller.layerconfig.pop_layer_tw_infos"
}) do
	table.merge(var_0_0, (require(iter_0_1)))
end

return var_0_0
