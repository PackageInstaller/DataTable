return {
	_rule_ = {
		none = {
			answer_top = {
				path = "answer_top",
				list = {
					select_img_1 = {
						path = "answer_top/select_img_1",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					select_img_2 = {
						path = "answer_top/select_img_2",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					select_img_3 = {
						path = "answer_top/select_img_3",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					answer_txt = {
						path = "answer_top/answer_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					select_image = {
						path = "answer_top/select_image",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					select_img_4 = {
						path = "answer_top/select_img_4",
						list = {
							answer_text = {
								path = "answer_top/select_img_4/answer_text",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {}
			},
			select_btn = {
				path = "select_btn",
				list = {},
				component = {
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["answer_select/answer_top"] = "_control.answer_top",
			["answer_select/answer_top/select_img_4"] = "_control.answer_top.select_img_4",
			["answer_select/answer_top/answer_txt"] = "_control.answer_top.answer_txt",
			["answer_select/answer_top/select_img_1"] = "_control.answer_top.select_img_1",
			["answer_select/answer_top/select_img_4/answer_text"] = "_control.answer_top.select_img_4.answer_text",
			["answer_select/answer_top/select_img_2"] = "_control.answer_top.select_img_2",
			["answer_select/select_btn"] = "_control.select_btn",
			["answer_select/answer_top/select_image"] = "_control.answer_top.select_image",
			["answer_select/answer_top/select_img_3"] = "_control.answer_top.select_img_3"
		},
		click = {
			select_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}
