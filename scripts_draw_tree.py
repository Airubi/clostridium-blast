from Bio import Phylo
import matplotlib.pyplot as plt

tree_file = "results/dnaA_four_strains_named_tree.contree"
output_file = "results/figures/dnaA_phylogenetic_tree.png"

tree = Phylo.read(tree_file, "newick")

# ปรับชื่อให้แสดงผลอ่านง่าย
names = {
    "NCIMB8052|CP000721.1": "NCIMB 8052",
    "ATCC35702|NZ_CP006777.1": "ATCC 35702",
    "NRRLB598|NZ_CP011966.3": "NRRL B-598",
    "NCIMB14988|NZ_CP010086.2": "NCIMB 14988",
}

for tip in tree.get_terminals():
    tip.name = names.get(tip.name, tip.name)

fig = plt.figure(figsize=(10, 5))
ax = fig.add_subplot(1, 1, 1)

Phylo.draw(
    tree,
    axes=ax,
    do_show=False,
    show_confidence=True
)

ax.set_title("Phylogenetic tree of dnaA sequences")
ax.set_xlabel("Substitutions per site")
fig.tight_layout()
fig.savefig(output_file, dpi=300, bbox_inches="tight")
plt.close(fig)

print(f"Tree image saved to: {output_file}")
