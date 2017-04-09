namespace Ado
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class Adodata : DbContext
    {
        public Adodata()
            : base("name=Adodata")
        {
        }

        public virtual DbSet<Administrator> Administrator { get; set; }
        public virtual DbSet<PkcInfo> PkcInfo { get; set; }
        public virtual DbSet<PkrInfo> PkrInfo { get; set; }
        public virtual DbSet<PkzInfo> PkzInfo { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Administrator>()
                .Property(e => e.UserName)
                .IsUnicode(false);

            modelBuilder.Entity<Administrator>()
                .Property(e => e.PWD)
                .IsUnicode(false);

            modelBuilder.Entity<PkcInfo>()
                .Property(e => e.PkcName)
                .IsUnicode(false);

            modelBuilder.Entity<PkcInfo>()
                .Property(e => e.PkcYear)
                .IsUnicode(false);

            modelBuilder.Entity<PkcInfo>()
                .Property(e => e.PkcIndustry)
                .IsUnicode(false);

            modelBuilder.Entity<PkcInfo>()
                .Property(e => e.PkcMember)
                .IsUnicode(false);

            modelBuilder.Entity<PkcInfo>()
                .HasMany(e => e.PkrInfo)
                .WithRequired(e => e.PkcInfo)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.PkrName)
                .IsUnicode(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.Gender)
                .IsUnicode(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.Education)
                .IsUnicode(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.IsDisabled)
                .IsUnicode(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.Home)
                .IsUnicode(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.Relationship)
                .IsUnicode(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.TpYear)
                .IsUnicode(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.YtpYear)
                .IsUnicode(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.IsTp)
                .IsUnicode(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.TpReason)
                .IsUnicode(false);

            modelBuilder.Entity<PkrInfo>()
                .Property(e => e.BbrInfo)
                .IsUnicode(false);

            modelBuilder.Entity<PkzInfo>()
                .Property(e => e.PkzName)
                .IsUnicode(false);
        }
    }
}
