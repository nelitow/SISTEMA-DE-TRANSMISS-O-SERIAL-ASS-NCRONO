transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/alunos/nelito.j/repo_final_dlp/SISTEMA-DE-TRANSMISS-O-SERIAL-ASS-NCRONO/detector_paridade.vhd}

