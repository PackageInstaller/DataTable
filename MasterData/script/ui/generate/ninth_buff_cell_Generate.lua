return {
	_rule_ = {
		none = {
			lvl_bg = {
				path = "lvl_bg",
				list = {
					lvl_text = {
						path = "lvl_bg/lvl_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			detail_mask = {
				path = "detail_mask",
				list = {
					detail_txt = {
						path = "detail_mask/detail_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					detail_txt2 = {
						path = "detail_mask/detail_txt2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask",
					"TextScroller"
				}
			},
			detail_txt = {
				path = "detail_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text",
					"UnityEngine.UI.ContentSizeFitter"
				}
			}
		},
		call_node_list = {
			["ninth_buff_cell/lvl_bg/lvl_text"] = "_control.lvl_bg.lvl_text",
			["ninth_buff_cell/lvl_bg"] = "_control.lvl_bg",
			["ninth_buff_cell/detail_txt"] = "_control.detail_txt",
			["ninth_buff_cell/detail_mask/detail_txt2"] = "_control.detail_mask.detail_txt2",
			["ninth_buff_cell/detail_mask"] = "_control.detail_mask",
			["ninth_buff_cell/detail_mask/detail_txt"] = "_control.detail_mask.detail_txt"
		},
		canvas_set = {}
	}
}
